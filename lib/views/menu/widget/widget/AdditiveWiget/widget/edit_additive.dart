import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/pack_field.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/create_dditive_controller.dart';
import 'package:vendor/models/fetch_additive_model.dart';
import 'package:vendor/models/update_additive_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class EditSingleAdditive extends HookWidget {
  const EditSingleAdditive(
      {super.key, required this.additive, required this.id, this.refetch});

  final FetchAdditiveModel additive;
  final Function()? refetch;
  final String id;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdditiveController());

    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 25.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        color: Tcolor.White,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableText(
                title: "Edit additive",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32.sp,
                  color: Tcolor.Text,
                ),
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
                      controller.additiveName.text = "";
                        controller.additivePrice.text = "";
                        controller.isAvailable.value = false;
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
            height: 10.h,
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(height: 40.h),
                  ReuseableText(
                    title: "Additive name",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28.sp,
                      color: Tcolor.TEXT_Label,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  PackField(
                    controller: controller.additiveName,
                    hintText: "e.g Extras",
                    suffixIcon: Icon(
                      HeroiconsOutline.chevronDown,
                      size: 28.sp,
                      color: Tcolor.BACKGROUND_Regaular,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  ReuseableText(
                    title: "Price",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28.sp,
                      color: Tcolor.TEXT_Label,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  PackField(
                    controller: controller.additivePrice,
                    hintText: "500",
                    suffixIcon: Icon(
                      HeroiconsOutline.chevronDown,
                      size: 28.sp,
                      color: Tcolor.BACKGROUND_Regaular,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReuseableText(
                        title: "Mark item in stock",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 28.sp,
                            color: Tcolor.Text),
                      ),
                      Obx(
                        () => Transform.scale(
                          scale: 0.6,
                          child: Switch.adaptive(
                            value: controller.isAvailable.value,
                            onChanged: controller.toggleSwitch,
                            activeColor:
                                Tcolor.PRIMARY_Button_color_2, // Active color
                            thumbColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.white; // White thumb when active
                              }
                              return Tcolor
                                  .White; // Regular thumb when inactive
                            }),
                            inactiveThumbColor:
                                Tcolor.BACKGROUND_Dark, // Inactive color
                          ),
                        ),
                      ),
                    ],
                  ),
                ])),
          ),
          SizedBox(height: 20.h), // Adjust if needed for padding
          GestureDetector(
                onTap: () {
                  if (controller.additiveName.text.isNotEmpty &&
                      controller.additivePrice.text.isNotEmpty) {
                    int price =
                        int.tryParse(controller.additivePrice.text) ?? 0;
                    UpdateAdditiveOptionModel model = UpdateAdditiveOptionModel(
                        name: controller.additiveName.text,
                        price: price,
                        isAvailable: controller.isAvailable.value);

                    String data = updateAdditiveOptionModelToJson(model);
                    print("Data: $data");
                    controller.updateSingleAdditive(
                        data, additive.id, id, refetch!);
                    controller.additiveName.text = "";
                    controller.additivePrice.text = "";
                    controller.isAvailable.value = false;

                    Get.back();
                  }
                },
                child: CustomButton(
                    title: "Update additive",
                    fontSize: 28.sp,
                    textColor: Tcolor.Text,
                    fontWeight: FontWeight.w500,
                    showArrow: false,
                    btnHeight: 80.h,
                    btnWidth: MediaQuery.of(context).size.width,
                    raduis: 100.r,
                    btnColor: Tcolor.PRIMARY_Button_color_2,
                    onTap: () {
                      print("Tapped");
                      print(controller.additiveName.text);
                      
                      if (controller.additiveName.text.isNotEmpty &&
                          controller.additivePrice.text.isNotEmpty) {
                        int price =
                            int.tryParse(controller.additivePrice.text) ?? 0;
                        UpdateAdditiveOptionModel model =
                            UpdateAdditiveOptionModel(
                                name: controller.additiveName.text,
                                price: price,
                                isAvailable: controller.isAvailable.value);

                        String data = updateAdditiveOptionModelToJson(model);
                        print("Data: $data");
                        controller.updateSingleAdditive(
                            data, additive.id, id, refetch!);
                        controller.additiveName.text = "";
                        controller.additivePrice.text = "";
                        controller.isAvailable.value = false;

                        Get.back();
                      }
                    }),
              ),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}
