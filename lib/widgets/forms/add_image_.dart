import 'package:flutter/material.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key, required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: 120,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.white
            ),
            borderRadius: BorderRadius.circular(60)
          ),
          child: body
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Icon(Icons.add),
          )
        )
      ],
    );
  }
}