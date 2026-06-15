
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingLottie extends StatelessWidget {
  const LoadingLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.transparent,    // Colors.black.withOpacity(0.5),
      child: LottieBuilder.asset(
        'assets/animation/loading_state.json', // Replace with your Lottie file path
        width: 30.w,
        height: 30.h,
      ),
    );
  }
}
