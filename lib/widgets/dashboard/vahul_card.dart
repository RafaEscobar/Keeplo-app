import 'package:flutter/material.dart';
import 'package:keeplo/models/vahul.dart';

class VahulCard extends StatelessWidget {
  const VahulCard({super.key, required this.vahul});
  final Vahul vahul;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        spacing: 10,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipOval(
              child: Image.network(
                vahul.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Text(
              vahul.name,
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}