import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/bloc/item_bloc/item_state.dart';
import 'package:flutter/material.dart';
import 'package:keeplo/models/item.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/widgets/simple_button.dart';
import 'package:keeplo/widgets/simple_image.dart';
import 'package:keeplo/widgets/simple_modal.dart';
import 'package:keeplo/widgets/simple_pill.dart';

class ItemActions {
  static void onDelete(BuildContext context, int itemId) {
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
          child: Center(
            child: SizedBox(
              width: context.isTabletLandscape ? 500 : (context.isTabletPortrait ? 380 : 300),
              child: AlertDialog(
                backgroundColor: AppTheme.primary,
                title: Text(
                  "¿Realmente deseas eliminar este item?",
                  style: TextStyle(fontSize: context.isTabletLandscape ? 30 : 18, color: Colors.white),
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
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 2, vertical: 2),
                  ),
                  SizedBox(height: 15,),
                  SimpleButton(
                    text: "Cancelar",
                    callback: () => Navigator.of(context).pop(),
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 2, vertical: 2),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void openItemDetails({required BuildContext context, required Item item}){
    SimpleModal.openModal(
      context: context,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            ClipOval(
              child: SimpleImage(imagePath: item.image, width: 100,)
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("Cantidad: ${item.amount}", style: TextStyle(color: Colors.white, fontSize: 18),),
                    ],
                  ),
                ),
                SimplePill(status: item.status == 1)
              ],
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.observations.isNotEmpty ? item.observations : 'Sin observaciones...',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w200),
              ),
            ),
          ],
        )
      ),
    );
  }
}