import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AwaitingVerification extends StatelessWidget {
  const AwaitingVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h, bottom: 30.h),
      height: 520.h,
      width: width,
      decoration: BoxDecoration(
          color: Tcolor.BACKGROUND_Regaular,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Tcolor.BORDER_Light)),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/img/checkers.png", height: 300.h, width: 360.w)),
          SizedBox(height: 30.h,),
          ReuseableText(
            title: "Awaiting Verfication",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36.sp,
                color: Tcolor.Text),
          ),
          SizedBox(height: 15.h,),

          ReuseableText(
            title: "You will receive an update on your verification",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 28.sp,
                color: Tcolor.Text),
          ),
          SizedBox(height: 5.h,),

          ReuseableText(
            title: "status within 2-3 days.",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 28.sp,
                color: Tcolor.Text),
          ),
          
        ],
      ),
    );
  }
}
