import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class AddFoodWidget extends StatelessWidget {
  const AddFoodWidget({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h,
      width: 270.w,
      decoration: BoxDecoration(
        color: Tcolor.PRIMARY_Button_color_2,
          borderRadius: BorderRadius.circular(100.r),),
          
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              HeroiconsOutline.plus,
              size: 28.sp,
              color: Tcolor.Text,
            ),
            SizedBox(width: 10.w,),
            ReuseableText(
              title: title,
              style: TextStyle(
                  color: Tcolor.Text,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
