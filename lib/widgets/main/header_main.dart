import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            width: 120.w,
            height: 80.h,
            child: Placeholder(),
          ),
        ),
        SizedBox(height: 20.h,),
        Text(
          title,
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        SizedBox(height: 10,),
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