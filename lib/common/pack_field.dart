import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackField extends StatelessWidget {
   const PackField({
    super.key,
    this.controller, this.hintText, this.prefix, this.keyboardType, this.height, this.width1, this.suffixIcon, this.color, this.prefixIcon
    
  });

  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final double? height;
  final double? width1;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 90.h,
      width: width1 ?? width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Tcolor.BACKGROUND_Regaular),
        color: Tcolor.BACKGROUND_Regaular,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 30.sp,
          color: Tcolor.TEXT_Body,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          fillColor: Tcolor.BACKGROUND_Regaular,
          filled: true,
          prefix: prefix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 15.r,
          ),
          hintStyle: TextStyle(
            color: color ?? Tcolor.TEXT_Placeholder,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
