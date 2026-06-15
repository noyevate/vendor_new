import 'package:vendor/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCirclePin extends StatelessWidget {
  const CustomCirclePin({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 16.w ,
      height: height ?? 16.h,
      decoration: BoxDecoration(
        color: Tcolor.Text,
        shape: BoxShape.circle,
      ),
    );
  }
}
