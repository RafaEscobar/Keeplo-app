import 'package:flutter/material.dart';
import 'package:keeplo/models/item.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/items/item_actions.dart';
import 'package:keeplo/widgets/simple_pill.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});
  final Item item;

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
          ItemActions.onDelete(context, item.id);
        } else {
          // Editar item [TODO]
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          ItemActions.openItemDetails(context: context, item: item);
        },
        child: Container(
          color: Colors.transparent,
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
                    SimplePill(
                      status: item.status == 1
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}