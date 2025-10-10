import 'package:flutter/material.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/bloc/item_bloc/item_state.dart';
import 'package:keeplo/models/item.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/widgets/simple_button.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});
  final Item item;

  void _onDelete(BuildContext context, int itemId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocListener<ItemBloc, ItemState>(
          listener: (listenerContext, state) {
            if (state.status == ItemStatus.removing) {
              showDialog(
                context: listenerContext,
                barrierDismissible: false,
                builder: (_) => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            } else if (state.status == ItemStatus.itemRemoved) {
              //* Cerrar el diálogo de progreso (si está abierto)
              if (Navigator.of(listenerContext).canPop()) {
                Navigator.of(listenerContext).pop();
              }
              //* Luego cerrar el AlertDialog
              Navigator.of(listenerContext).pop();

              listenerContext.read<ItemBloc>().add(GetItemsEvent());
            }
          },
          child: AlertDialog(
            backgroundColor: AppTheme.primary,
            title: const Text(
              "¿Realmente deseas eliminar este baúl?",
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              SimpleButton(
                text: "Eliminar",
                callback: () {
                  context.read<ItemBloc>().add(ItemDeleteEvent(itemId));
                },
                backgroundColor: AppTheme.error,
                textColor: Colors.white,
              ),
              SizedBox(height: 15,),
              SimpleButton(
                text: "Cancelar",
                callback: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: AppTheme.error,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(margin: EdgeInsets.only(left: 26), child: Icon(Icons.delete, size: 36, color: Colors.white,)),
        ),
      ),
      secondaryBackground: Container(
        color: AppTheme.info,
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(margin: EdgeInsets.only(right: 26), child: Icon(Icons.edit, size: 36, color: AppTheme.primary,))
        ),
      ),
      key: ValueKey<int>(item.id),
      onDismissed: (direction) {

      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          _onDelete(context, item.id);
        } else {
          // Editar item [TODO]
        }
        return false;
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          spacing: 12,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: ClipOval(child: Image.network("https://i.ibb.co/VcrM7rBV/a.png", fit: BoxFit.cover,))
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    item.name, style: TextStyle(color: Colors.white, fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: item.status == 1 ? AppTheme.info : AppTheme.error,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(item.status == 1 ? "Disponible" : "No disponible" , style: TextStyle(color: item.status == 1 ? AppTheme.primary : Colors.white),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}