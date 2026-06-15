import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/pack_field.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/create_dditive_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class AddAdditiveCategory extends StatelessWidget {
  const AddAdditiveCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdditiveController());
    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        color: Tcolor.White,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableText(
                title: "Add additive category",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 32.sp,
                    color: Tcolor.Text),
              ),
              Container(
                height: 70.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: Tcolor.BACKGROUND_Dark,
                  borderRadius: BorderRadius.circular(60.r),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      controller.additiveCategory.text == "";
                      Get.back();
                    },
                    icon: Icon(
                      HeroiconsOutline.xMark,
                      color: Tcolor.Text,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          ReuseableText(
            title: "Category name",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
                color: Tcolor.TEXT_Label),
          ),
          SizedBox(
            height: 10.w,
          ),
          PackField(
            controller: controller.additiveCategory,
            hintText: "e.g Extras",
            suffixIcon: Icon(
              HeroiconsOutline.chevronDown,
              size: 28.sp,
              color: Tcolor.BACKGROUND_Regaular,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                    title: "Select at least",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.sp,
                        color: Tcolor.TEXT_Label),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  PackField(
                    width1: 300.w,
                    controller: controller.minController,
                    hintText: "0",
                    color: Tcolor.TEXT_Body,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                    title: "Select at most",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.sp,
                        color: Tcolor.TEXT_Label),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  PackField(
                    width1: 300.w,
                    controller: controller.maxController,
                    hintText: "0",
                    color: Tcolor.TEXT_Body,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Obx(() => GestureDetector(
                onTap: controller.isFormFilled.value
                    ? () {
                        // Your logic to add category
                        Get.back();
                      }
                    : null, // Dis
                child: CustomButton(
                  title: "Add category",
                  fontSize: 28.sp,
                  textColor: controller.isFormFilled.value
                      ? Tcolor.Text
                      : Tcolor.TEXT_Label,
                  fontWeight: FontWeight.w500,
                  showArrow: false,
                  btnHeight: 80.h,
                  btnWidth: width,
                  raduis: 100.r,
                  btnColor: controller.isFormFilled.value
                      ? Tcolor
                          .PRIMARY_Button_color_2 // Gradient takes precedence
                      : Tcolor
                          .BACKGROUND_Regaular, // Solid color when not active,

                  onTap: controller.isFormFilled.value
                      ? () {
                          // Your logic to add category
                          Get.back();
                        }
                      : null, // Disable button when inactive
                ),
              )),
          SizedBox(
            height: 60.h,
          ),
        ],
      ),
    );
  }
}
