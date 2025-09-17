import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeplo/utils/responsive.dart';

class HeaderMain extends StatelessWidget {
  const HeaderMain({super.key, required this.imageUrl, required this.title});
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = context.isTabletLandscape;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: isHorizontal ? 190 : 120.w,
            height: isHorizontal ? 90 : 80.h,
            child: Placeholder(),
          ),
        ),
        SizedBox(height: 20.h,),
        Text(
          title,
          style: TextStyle(fontSize: isHorizontal ? 52 : 28.sp, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        SizedBox(height: isHorizontal ? 30 : 10,),
        Center(
          child: Image.asset(
            imageUrl,
            width: 300.w,
          )
        ),
      ],
    );
  }
}