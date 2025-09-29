import 'package:flutter/material.dart';
import 'package:keeplo/models/item.dart';
import 'package:keeplo/theme/app_theme.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}