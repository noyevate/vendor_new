import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custim_checkbox.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/pack_field.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/create_dditive_controller.dart';
import 'package:vendor/models/edit_category_model.dart';
import 'package:vendor/models/fetch_additive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class EditAdditiveCategory extends HookWidget {
  const EditAdditiveCategory({super.key, required this.additive,
    this.refetch});

  final FetchAdditiveModel additive;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    final checkedItems = useState<List<bool>>(
        List.generate(additive.options.length, (index) => false));
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
                title: "Edit additive category",
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
            height: 10.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  ReuseableText(
                    title: "Category name",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28.sp,
                      color: Tcolor.TEXT_Label,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  PackField(
                    controller: controller.additiveCategory,
                    hintText: "e.g Extras",
                    suffixIcon: Icon(
                      HeroiconsOutline.chevronDown,
                      size: 28.sp,
                      color: Tcolor.BACKGROUND_Regaular,
                    ),
                  ),
                  SizedBox(height: 40.h),
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
                              color: Tcolor.TEXT_Label,
                            ),
                          ),
                          SizedBox(height: 10.w),
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
                              color: Tcolor.TEXT_Label,
                            ),
                          ),
                          SizedBox(height: 10.w),
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
                  SizedBox(height: 40.h),
                  ReuseableText(
                    title: "Additives",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 32.sp,
                      color: Tcolor.Text,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    children: List.generate(additive.options.length, (index) {
                      Option additiveFood = additive.options[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 30.h, bottom: 40.h),
                                child: CustomCircularCheckbox(
                                  value: checkedItems.value[index],
                                  onChanged: (bool? value) {
                                    checkedItems.value =
                                        List<bool>.from(checkedItems.value)
                                          ..[index] = value ?? false;
                                  },
                                ),
                              ),
                              SizedBox(width: 30.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReuseableText(
                                    title: additiveFood.additiveName,
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Tcolor.Text,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              HeroiconsOutline.pencil,
                              color: Tcolor.PRIMARY_S4,
                              size: 32.sp,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h), // Adjust if needed for padding
          Obx(() => GestureDetector(
                onTap: controller.isFormFilled.value
                    ? () {
                      print("Tapprd");
                        int min =
                            int.tryParse(controller.minController.text) ?? 0;
                        int max =
                            int.tryParse(controller.maxController.text) ?? 0;
                        EditAdditiveCategoryModel model =
                            EditAdditiveCategoryModel(
                                additiveTitle: controller.additiveCategory.text,
                                min: min,
                                max: max);

                        String data = editAdditiveCategoryModelToJson(model);
                        controller.editAdditiveCategory(data, additive.id, refetch!);
                        controller.additiveCategory.text = "";
                        controller.maxController.text = "";
                        controller.minController.text = "";

                        Get.back();
                      }
                    : null,
                child: CustomButton(
                  title: "Update category",
                  fontSize: 28.sp,
                  textColor: controller.isFormFilled.value
                      ? Tcolor.Text
                      : Tcolor.TEXT_Label,
                  fontWeight: FontWeight.w500,
                  showArrow: false,
                  btnHeight: 80.h,
                  btnWidth: MediaQuery.of(context).size.width,
                  raduis: 100.r,
                  btnColor: controller.isFormFilled.value
                      ? Tcolor.PRIMARY_Button_color_2
                      : Tcolor.BACKGROUND_Regaular,
                  onTap: controller.isFormFilled.value
                      ? () {
                          print("Tapprd2");
                        int min =
                            int.tryParse(controller.minController.text) ?? 0;
                        int max =
                            int.tryParse(controller.maxController.text) ?? 0;
                        EditAdditiveCategoryModel model =
                            EditAdditiveCategoryModel(
                                additiveTitle: controller.additiveCategory.text,
                                min: min,
                                max: max);

                        String data = editAdditiveCategoryModelToJson(model);
                        controller.editAdditiveCategory(data, additive.id, refetch!);
                        controller.additiveCategory.text = "";
                        controller.maxController.text = "";
                        controller.minController.text = "";

                        Get.back();
                        
                        }
                      : null,
                ),
              )),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}
