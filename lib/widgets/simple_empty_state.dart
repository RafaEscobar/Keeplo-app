import 'package:flutter/material.dart';

class SimpleEmptyState extends StatelessWidget {
  const SimpleEmptyState({super.key, required this.label, required this.imageUrl});
  final String label;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    imageUrl,
                    width: 200,
                  )
                ),
                Text(
                  label,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ),
    );
  }
}