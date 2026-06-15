import 'package:vendor/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    super.key,
    this.prefixIcon,
    this.labelText,
    this.prefixIconColor,
    this.cursorColor,
    this.textInputAction,
    this.onEditingComplete,
    this.controller,
    this.initialValue,
    this.validator,
    this.keyboardType,
    this.hintFontSize,
    this.hintColor,
    this.hintFontWeight,
    this.hintText,
    this.cursorHeight,
    this.height,
    this.width,
    this.enabled = true,
    this.onChanged, this.maxLength, this.focusNode, this.fillColor, this.borderRadius, this.borderColor = Colors.transparent, this.isValid = true, this.obscureText,
  });

  final Widget? prefixIcon;
  final String? labelText;
  final Color? prefixIconColor;
  final Color? cursorColor;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final double? hintFontSize;
  final Color? hintColor;
  final FontWeight? hintFontWeight;
  final String? hintText;
  final double? cursorHeight;
  final double? height;
  final double? width;
  final bool enabled;
  final void Function(String)? onChanged;
  final int? maxLength;
  final FocusNode? focusNode;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final Color borderColor;
  final bool isValid;
  final bool? obscureText;
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        obscuringCharacter: "*",
        obscureText: obscureText ?? false,
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
        maxLengthEnforcement: MaxLengthEnforcement.none,
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        style: TextStyle(
            fontSize: 30.sp,
            color: Tcolor.TEXT_Body,
            fontWeight: FontWeight.w600),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          
          counterText: '',
          hintText: hintText,
          prefixIcon: prefixIcon,
          labelText: labelText,
          prefixIconColor: prefixIconColor,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: 10.h, horizontal: 15.r), // Adjust vertical padding
          filled: true,
          fillColor: fillColor ?? Tcolor.BACKGROUND_Regaular,
          hintStyle: TextStyle(
            fontSize: hintFontSize,
            color: hintColor,
            fontWeight: hintFontWeight,
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
          // focusedErrorBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Tcolor.ERROR_Reg,
          //     width: .5,
          //   ),
          //   borderRadius: BorderRadius.all(Radius.circular(16.r)),
          // ),
          // disabledBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(
          //     color: Colors.transparent,
          //     width: .5,
          //   ),
          //   borderRadius: BorderRadius.all(Radius.circular(16.r)),
          // ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: .5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          // border: OutlineInputBorder(
          //   borderSide:  BorderSide(
          //     color: Tcolor.ERROR_Reg,
          //     width: .5,
          //   ),
          //   borderRadius: BorderRadius.all(Radius.circular(24.r)),
          // ),
        ),
      ),
    );
  }
}
