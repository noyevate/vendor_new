import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessInsightTile extends StatelessWidget {
  const BusinessInsightTile({
    super.key, required this.title, required this.title1,
  });
  final String title;
  final String title1;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Tcolor.BACKGROUND_Regaular,
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
    
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
            height: 88.h,
            width: width,
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Tcolor.White),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReuseableText(
                  title: title,
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: Tcolor.TEXT_Label),
                ),
                ReuseableText(
                  title: "$title1",
                  style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: Tcolor.Text),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
