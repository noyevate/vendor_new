import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custim_checkbox.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/format_price.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/create_dditive_controller.dart';
import 'package:vendor/models/fetch_additive_model.dart';
import 'package:vendor/views/menu/widget/widget/AdditiveWiget/widget/edit_additive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import 'edit_additive_category.dart';

class AdditiveTile extends HookWidget {
  const AdditiveTile({Key? key, required this.additive, this.refetch})
      : super(key: key);

  final FetchAdditiveModel additive;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    final checkedItems = useState<List<bool>>(
        List.generate(additive.options.length, (index) => false));
    final controller = Get.put(AdditiveController());

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Tcolor.White,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableText(
                title: additive.additiveTitle,
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Tcolor.Text,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.updateAdditiveAvailability(
                          additive.id, refetch!);
                    },
                    child: ReuseableText(
                      title: "Out of stock",
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: additive.isAvailable
                            ? Tcolor.BORDER_Light
                            : Tcolor.ERROR_Reg,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    color: Tcolor.BORDER_Light,
                    height: 28.h,
                    width: 2.w,
                  ),
                  SizedBox(width: 20.w),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Tcolor.White,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r))),
                              height: 1150.h,
                              width: width,
                              child: EditAdditiveCategory(
                                additive: additive,
                                refetch: refetch ?? () {},
                              ),
                            );
                          });
                    },
                    child: Icon(
                      HeroiconsOutline.pencil,
                      color: Tcolor.PRIMARY_S4,
                      size: 32.sp,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  GestureDetector(
                    onTap: () {
                      _showPopup(
                          context,
                          "Delete additive category",
                          "Are you sure you want to delete this additive",
                          "category?","");
                    },
                    child: Icon(
                      HeroiconsOutline.trash,
                      color: Tcolor.ERROR_Reg,
                      size: 32.sp,
                    ),
                  ),
                ],
              ),
            ],
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
                        padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
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
                          Row(
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                   children: [
                                    Text("₦", style: TextStyle(
                                         fontSize: 25.sp,
                                         color: Tcolor.TEXT_Placeholder,
                                         fontWeight: FontWeight.w400,
                                       ),),
                                     ReuseableText(
                                       title: formatPrice(additiveFood.price),
                                       style: TextStyle(
                                         fontSize: 28.sp,
                                         color: Tcolor.TEXT_Placeholder,
                                         fontWeight: FontWeight.w400,
                                       ),
                                     ),
                                   ],
                                 ),
                              SizedBox(width: 20.w),
                              Container(
                                decoration: BoxDecoration(
                                  color: additiveFood.isAvailable
                                      ? Tcolor.SUCCESS_Reg
                                      : Tcolor.ERROR_Reg,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: ReuseableText(
                                      title: additiveFood.isAvailable
                                          ? "In-stock"
                                          : "Out of stock",
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Tcolor.White,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Tcolor.White,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.r),
                                          topRight: Radius.circular(20.r))),
                                  height: 1150.h,
                                  width: width,
                                  child: EditSingleAdditive(
                                    additive: additive,
                                    refetch: refetch ?? () {},
                                    id: additiveFood.id,
                                  ),
                                );
                              });
                        },
                        child: Icon(
                          HeroiconsOutline.pencil,
                          color: Tcolor.PRIMARY_S4,
                          size: 32.sp,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GestureDetector(
                        onTap: () {
                          _showPopup(
                              context,
                              "Delete additive",
                              "Are you sure you want to delete this additive?",
                              "", additiveFood.id);
                        },
                        child: Icon(
                          HeroiconsOutline.trash,
                          color: Tcolor.ERROR_Reg,
                          size: 32.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showPopup(
      BuildContext context, String title1, String title2, String title3, String? optionId) {
    final controller = Get.put(AdditiveController());

    showDialog(
        context: context,
        barrierColor:
            const Color.fromRGBO(18, 20, 25, 0.8), // Dark overlay color
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: 530.w,
              height: title3.isNotEmpty ? 260.h : 220.h,
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, bottom: 10.h, top: 30.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReuseableText(
                    title: title1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.sp,
                        color: Tcolor.Text),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ReuseableText(
                    title: title2,
                    style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  if (title3 != null && title3.isNotEmpty)
                    ReuseableText(
                      title: title3,
                      style: TextStyle(
                          color:
                              Tcolor.TEXT_Label, // You can style it differently
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the Row content
                    children: [
                      CustomButton(
                        title: "No, Cancel",
                        showArrow: false,
                        btnColor: Tcolor.White,
                        btnWidth: 220.w,
                        btnHeight: 72.h,
                        textColor: Tcolor.TEXT_Body,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w400,
                        onTap: () async {
                          Get.back();
                        },
                      ),
                      SizedBox(
                          width: 10.w), // Space between buttons and divider
                      Container(
                        height: 50.h,
                        width: 5.w,
                        color: Tcolor.BACKGROUND_Dark,
                      ),
                      SizedBox(width: 10.w), // Space between divider and button
                      CustomButton(
                        title:
                            "Yes, Delete", // Changed title for differentiation
                        showArrow: false,
                        btnColor: Tcolor.White,
                        btnWidth: 220.w,
                        btnHeight: 72.h,
                        textColor: Tcolor.ERROR_Reg,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w400,

                        onTap: () async {
                          if (title3.isNotEmpty) {
                            controller.deleteAdditiveCategory(
                                additive.id, refetch!);
                            Get.back();
                          } else {
                            controller.deleteAdditiveOption(
                                additive.id, optionId!, refetch!);
                            Get.back();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
