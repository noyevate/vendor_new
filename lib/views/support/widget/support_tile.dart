

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class SupportTile extends StatelessWidget {
  const SupportTile({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r), color: Tcolor.White),
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReuseableText(
              title: title,
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text),
            ),
            Icon(HeroiconsOutline.chevronRight, size: 32.sp, color: Tcolor.TEXT_Label,)
          ],
        ),
      ),
    );
  }
}
