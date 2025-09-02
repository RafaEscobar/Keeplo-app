import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleEmptyState extends StatelessWidget {
  const SimpleEmptyState({super.key, required this.label, required this.imageUrl});
  final String label;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                imageUrl,
                width: 300.w,
              )
            ),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ],
        )
      )
    );
  }
}