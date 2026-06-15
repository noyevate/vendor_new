import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class RestaurantProfileTile extends StatelessWidget {
  const RestaurantProfileTile({
    super.key,
    required this.title,
    required this.icon,
    this.color,
    this.onTap,
    this.size,
    this.fontSize,
    this.icon2, this.color2, this.color3,
  });
  final String title;
  final IconData icon;
  final Color? color;
  final void Function()? onTap;
  final double? size;
  final double? fontSize;
  final IconData? icon2;
  final Color? color2;
  final Color? color3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: size ?? 40.sp,
                  color: color3 ?? Tcolor.TEXT_Label,
                ),
                SizedBox(
                  width: 20.w,
                ),
                ReuseableText(
                  title: title,
                  style: TextStyle(
                      fontSize: fontSize ?? 28.sp,
                      fontWeight: FontWeight.w400,
                      color: color ?? Tcolor.Text),
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  icon2,
        
                  // HeroiconsSolid.checkCircle,
                  size: size ?? 40.sp,
                  color: color ?? Tcolor.SECONDARY_Button,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Icon(
                  HeroiconsOutline.chevronRight,
                  size: 32.sp,
                  color: Tcolor.Text_Secondary,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
