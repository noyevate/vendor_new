import 'package:vendor/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetupField extends StatelessWidget {
  const SetupField({
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
    required this.controller, // Made controller required to avoid null
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
    this.onTap, 
    this.sufixIcon, this.contentPadding, // Add onTap
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
  final TextEditingController controller; // Required controller
  final String? initialValue;
  final String? Function(String?)? validator;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final String? labelText;
  final Color? prefixIconColor;
  final Color? fillColor;
  final VoidCallback? onTap; // Add onTap callback
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 95.h,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Tcolor.BORDER_Light),
        color: Tcolor.BACKGROUND_Regaular,
      ),
      child: TextFormField(
        focusNode: focusNode,
        onChanged: onChanged,
        controller: controller, // Use the passed-in controller
        cursorColor: Tcolor.Text,
        enabled: true,
        readOnly: onTap != null, // Set to read-only if onTap is provided

        maxLines: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        cursorHeight: cursorHeight,
        
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        validator: validator,
        
        keyboardType: keyboardType ?? TextInputType.text,
        style: TextStyle(
          fontSize: 30.sp,
          color: Tcolor.TEXT_Body,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          
          hintStyle: TextStyle(
            color: Tcolor.TEXT_Placeholder,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
          labelText: labelText,
          prefixIconColor: prefixIconColor,
          isDense: true,
          fillColor: fillColor ?? Tcolor.BACKGROUND_Regaular,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: contentPadding ?? EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 15.r,
          ),
        ),
          onTap: onTap, // Trigger navigation on tap

      ),
    );
  }
}
