import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuTabWidget extends StatelessWidget {
  const MenuTabWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
      width: width/5,
      height: 50.h,
      child: Center(
        child: Text(text),
      ),
    );
  }
}