import 'package:vendor/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCircularCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 40.h,
        height: 40.w,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: value ? const Color.fromRGBO(251, 178, 23, 1) : const Color.fromRGBO(216, 217, 220, 1),
            width: 2.0,
          ),
          color: value ? const Color.fromRGBO(251, 178, 23, 1) : Tcolor.White,
        ),
        child: value
            ?  Center(
                child: Icon(
                  Icons.check,
                  size: 22.sp,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
