import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/pack_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/common/pack_field.dart';

import 'package:heroicons_flutter/heroicons_flutter.dart';

import '../../../../../models/update_pack_model.dart';

class UpdatePack extends StatelessWidget {
  const UpdatePack({super.key, required this.id, this.refetch});
  final String id;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PackController());
    return Container(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 25.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          color: Tcolor.White,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableText(
                title: "Edit pack",
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
                      controller.packDescriptionController.text = "";
                      controller.packNameController.text = "";
                      controller.packPriceController.text = "";
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
                  title: "Pack name",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 28.sp,
                    color: Tcolor.TEXT_Label,
                  ),
                ),
                SizedBox(height: 10.w),
                PackField(
                  controller: controller.packNameController,
                  hintText: "e.g Extras",
                  suffixIcon: Icon(
                    HeroiconsOutline.chevronDown,
                    size: 28.sp,
                    color: Tcolor.BACKGROUND_Regaular,
                  ),
                ),
                SizedBox(height: 40.h),
                ReuseableText(
                  title: "Pack description",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 28.sp,
                    color: Tcolor.TEXT_Label,
                  ),
                ),
                SizedBox(height: 10.w),
                PackField(
                  controller: controller.packDescriptionController,
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
                  controller: controller.packPriceController,
                  hintText: "e.g Extras",
                  keyboardType: TextInputType.number,
                  prefix: Text(
                    "₦  ",
                    style: TextStyle(
                      color: Tcolor.TEXT_Body,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  suffixIcon: Icon(
                    HeroiconsOutline.chevronDown,
                    size: 28.sp,
                    color: Tcolor.BACKGROUND_Regaular,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
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
                            return Tcolor.White; // Regular thumb when inactive
                          }),
                          inactiveThumbColor:
                              Tcolor.BACKGROUND_Dark, // Inactive color
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),

          SizedBox(height: 20.h), // Adjust if needed for padding
          GestureDetector(
            onTap: () {
              print("tapped");
              if (controller.packNameController.text.isNotEmpty &&
                  controller.packDescriptionController.text.isNotEmpty &&
                  controller.packPriceController.text.isNotEmpty) {
                int price =
                    int.tryParse(controller.packPriceController.text) ?? 0;
                UpdatePackModel model = UpdatePackModel(
                    packName: controller.packNameController.text,
                    packDescription: controller.packDescriptionController.text,
                    price: price,
                    isAvailable: controller.isAvailable.value);

                String data = updatePackModelToJson(model); 
                controller.updatePack(data, id, refetch!);

                controller.packNameController.text = "";
                  controller.packDescriptionController.text = "";
                  controller.packPriceController.text = "";

                Get.back();
              }
            },
            child: CustomButton(
                title: "Update Pack",
                fontSize: 28.sp,
                textColor: Tcolor.Text,
                fontWeight: FontWeight.w500,
                showArrow: false,
                btnHeight: 80.h,
                btnWidth: MediaQuery.of(context).size.width,
                raduis: 100.r,
                btnColor: Tcolor.PRIMARY_Button_color_2,
                onTap: () {}),
          ),
          SizedBox(height: 60.h),
        ]));
  }
}
