import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePasswordField extends StatelessWidget {
   const UpdatePasswordField({
    super.key,
    this.controller, this.hintText, this.prefix, this.keyboardType, this.height, this.width1, this.suffixIcon, this.color, this.prefixIcon, this.onChanged, required this.borderColor, this.fillColor
    
  });

  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final double? height;
  final double? width1;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  
  final Color? color;
  final Color borderColor;
  final Color? fillColor;

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
        onChanged: onChanged,
        obscureText: true,
        style: TextStyle(
          fontSize: 30.sp,
          color: Tcolor.TEXT_Body,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          fillColor: fillColor ??  Tcolor.BACKGROUND_Regaular,
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

          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Tcolor.ERROR_Reg,
              width: .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
        ),
      ),
    );
  }
}
