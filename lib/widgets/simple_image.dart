import 'package:flutter/material.dart';

class SimpleImage extends StatelessWidget {
  const SimpleImage({super.key, required this.imagePath, this.width = double.infinity});
  final String imagePath;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator(color: Colors.white,));
      },
      errorBuilder: (context, error, stackTrace) => Icon(Icons.question_mark_rounded, color: Colors.white, size: 34,),
      fit: BoxFit.cover,
      width: width,
    );
  }
}