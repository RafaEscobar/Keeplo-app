import 'package:flutter/material.dart';

class HeaderMain extends StatelessWidget {
  const HeaderMain({super.key, required this.imageUrl, required this.title});
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 120,
            height: 80,
            child: Placeholder(),
          ),
        ),
        SizedBox(height: 20,),
        Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        SizedBox(height: 10,),
        Center(
          child: Image.asset(
            imageUrl,
            width: 340,
          )
        ),
      ],
    );
  }
}