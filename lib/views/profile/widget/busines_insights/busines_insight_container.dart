import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinesInsightContainer extends StatelessWidget {
  const BusinesInsightContainer({
    super.key,
     required this.title1, required this.title2, required this.title3, this.title4
  });

  
  final String title1;
  final String title2;
  final String title3;
  final String? title4;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 10.h),
      height: 150.h,
      width: 315.w,
      decoration: BoxDecoration(
          border: Border.all(color: Tcolor.BORDER_Light),
          borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReuseableText(
            title: title1,
            style: TextStyle(
                color: Tcolor.TEXT_Label,
                fontSize: 28.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                 title3,
                style: TextStyle(
                    color: Tcolor.Text,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500),),
              SizedBox(
                width: 250.w,
                child: Text(
                   "$title4${title2}",
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      color: Tcolor.Text,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
