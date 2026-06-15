import 'package:vendor/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
    this.focusNode,
    this.onChanged,
    this.enabled,
    this.height,
    this.width,
    this.cursorHeight,
    this.cursorColor,
    this.textInputAction,
    this.onEditingComplete,
    this.controller,
    this.initialValue,
    this.validator,
    this.maxLength,
    this.maxLengthEnforcement,
    this.keyboardType,
    this.hintText,
    this.prefixIcon,
    this.labelText,
    this.prefixIconColor,
    this.fillColor,
  });

  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final bool? enabled;
  final double? height;
  final double? width;
  final double? cursorHeight;
  final Color? cursorColor;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final String? initialValue;
  final String? Function(String?)? validator;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? prefixIcon;
  final String? labelText;
  final Color? prefixIconColor;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      // Removed the fillColor from Container
      // decoration: BoxDecoration(
      //   //border: Border.all(color: Tcolor.BACKGROUND_Dark, width: 1.5),
      //   borderRadius: BorderRadius.circular(20.r),
      // ),
      child: TextFormField(
        focusNode: focusNode,
        onChanged: onChanged,
        enabled: enabled,
        cursorHeight: cursorHeight,
        cursorColor: cursorColor,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        controller: controller,
        initialValue: initialValue,
        validator: validator,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        style: TextStyle(
          fontSize: 30.sp,
          color: Tcolor.TEXT_Body,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          prefixIcon: prefixIcon,
          labelText: labelText,
          prefixIconColor: prefixIconColor,
          isDense: true,
          // Set the fillColor and filled property here
          fillColor: fillColor ?? Tcolor.BACKGROUND_Regaular,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none, // Remove default border color
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 15.r,
          ),
        ),
      ),
    );
  }
}
