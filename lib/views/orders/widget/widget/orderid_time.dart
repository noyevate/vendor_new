
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';

class OrderIdAndTime extends StatelessWidget {
  const OrderIdAndTime({
    super.key,
    this.fontWeight,
    required this.title1,
    required this.title2, this.width,
  });

  final FontWeight? fontWeight;
  final String title1;
  final String title2;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ReuseableText(
          title: title1,
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              color: Tcolor.TEXT_Label),
        ),
        SizedBox(
          width: width ?? 100.w,
          child: ReuseableText(
            title: title2,
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: fontWeight ?? FontWeight.w700,
                color: Tcolor.Text),
          ),
        ),
      ],
    );
  }
}
