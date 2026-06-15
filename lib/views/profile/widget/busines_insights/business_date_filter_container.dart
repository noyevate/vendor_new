import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessDateFilterContainer extends StatelessWidget {
  const BusinessDateFilterContainer({
    super.key,
    required this.selectedFilter,
    required this.color1,
    required this.title,
    required this.color2,
  });

  final String selectedFilter;
  final Color color1;
  final Color color2;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      width: 200.w,
      decoration: BoxDecoration(
          border: Border.all(color: color2),
          borderRadius: BorderRadius.circular(20.r),
          color: color1),
      child: Center(
        child: ReuseableText(
          title: title,
          style: TextStyle(
              fontSize: 28.sp, fontWeight: FontWeight.w400, color: Tcolor.Text),
        ),
      ),
    );
  }
}
