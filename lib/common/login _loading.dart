
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoadingImage extends StatelessWidget {
  const LoadingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Tcolor.White,
      child: Image.asset("assets/img/chopnow_logo.png", height: 30.h, width: 30.w,)
    );
  }
}
