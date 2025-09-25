import 'package:flutter/material.dart';
import 'package:keeplo/utils/responsive.dart';

class SimpleEmptyState extends StatelessWidget {
  const SimpleEmptyState({super.key, required this.label, required this.imageUrl});
  final String label;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, top: context.isTabletLandscape ? 0 : 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                imageUrl,
                width: context.isTabletLandscape ? 160 : context.isTabletPortrait ? 280 : 200,
              )
            ),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: context.isTabletLandscape ? 20 : context.isTabletPortrait ? 30 : 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
    );
  }
}