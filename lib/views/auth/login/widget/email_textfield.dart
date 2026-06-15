import 'package:vendor/common/color_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, this.onEditingComplete, this.hintText, this.keyboardType, this.initialValue, this.controller, this.prefixIcon, this.color, this.suffixIcon});
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final String? initialValue;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Color? color;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Tcolor.Text,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      initialValue: initialValue,
      controller: controller,
      validator: (value) {
        if(value!.isEmpty) {
          return "";
        } else {
          return null;
        }
      },
      style: TextStyle(color: Tcolor.TEXT_Body, fontWeight: FontWeight.w500, fontSize: 28.sp),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        isDense: true,
        // contentPadding: EdgeInsets.all(12.h),
        suffixIcon: suffixIcon,
          
          fillColor: Tcolor.BACKGROUND_Regaular,
          filled: true,
          
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
    );
  }
}