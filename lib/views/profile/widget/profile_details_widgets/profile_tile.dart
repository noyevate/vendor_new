import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/color_extension.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon, this.color, this.onTap, this.size, this.fontSize,
  });
  final String title;
  final IconData icon;
  final Color? color;
  final void Function()? onTap;
  final double? size;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: size ?? 40.sp ,
                color: color ?? Tcolor.TEXT_Label ,
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
          
          
        ],
      ),
    );
  }
}
