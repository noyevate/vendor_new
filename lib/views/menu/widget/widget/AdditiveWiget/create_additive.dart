// ignore_for_file: avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/setup_field.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/create_dditive_controller.dart';
import 'package:vendor/models/create_additive_model.dart';
// import 'package:vendor/models/food_model.dart';
import 'package:vendor/views/menu/widget/widget/AdditiveWiget/widget/add_addiive_category.dart';
import 'package:vendor/views/menu/widget/widget/AdditiveWiget/widget/additive_category.dart';
import 'package:vendor/views/menu/widget/widget/AdditiveWiget/widget/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:heroicons_flutter/heroicons_list.dart';
import 'package:lottie/lottie.dart';

class CreateAdditive extends StatefulWidget {
  const CreateAdditive({super.key, this.refetch});

  final Function()? refetch;

  @override
  State<CreateAdditive> createState() => _CreateAdditiveState();
}

class _CreateAdditiveState extends State<CreateAdditive> {
  // final List<Widget> additiveFields = [];

  // void addAdditiveField() {
  //   setState(() {
  //     additiveFields.add(additiveFieldWidget());
  //   });
  // }

  // void removeAdditiveField(int index) {
  //   setState(() {
  //     additiveFields.removeAt(index);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdditiveController());
    final box = GetStorage();
    var restaurantId = box.read("restaurantId");
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child: Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: SafeArea(
                child: Column(
                  children: [
                    const PageTitle(
                      title: "Add additive",
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReuseableText(
                      title: "Additive category",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SetupField(
                      width: width,
                      sufixIcon: GestureDetector(
                        onTap: () {
                          controller.clearTypes();
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
                                    child: const ChooseAdditiveCategory());
                              });
                        },
                        child: Icon(
                          HeroiconsOutline.chevronDown,
                          size: 28.sp,
                          color: Tcolor.TEXT_Label,
                        ),
                      ),
                      hintText: "Select category",
                      controller: controller.additiveCategory,
                      onTap: () {
                        controller.clearTypes();
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
                                child: const ChooseAdditiveCategory(),
                              );
                            });
                      },
                    ),
                    SizedBox(height: 15.h),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<String>(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return SizedBox(
                                height: 1150.h,
                                width: width,
                                child: const AddAdditiveCategory());
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            HeroiconsOutline.plus,
                            size: 32.sp,
                            color: Tcolor.PRIMARY_S4,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          ReuseableText(
                            title: "Add Additive category",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.sp,
                                color: Tcolor.PRIMARY_S4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                              title: "Additive name",
                              style: TextStyle(
                                color: Tcolor.TEXT_Label,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SetupField(
                              width: 300.w,
                              sufixIcon: Icon(
                                HeroiconsOutline.chevronDown,
                                size: 28.sp,
                                color: Tcolor.BACKGROUND_Regaular,
                              ),
                              hintText: "e.g cow meat",
                              controller: controller.additiveName,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                              title: "Additive price",
                              style: TextStyle(
                                color: Tcolor.TEXT_Label,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SetupField(
                              width: 300.w,
                              sufixIcon: Icon(
                                HeroiconsOutline.chevronDown,
                                size: 28.sp,
                                color: Tcolor.BACKGROUND_Regaular,
                              ),
                              hintText: "Price",
                              controller: controller.additivePrice,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Obx(
                      () => controller.optionList.isNotEmpty
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    controller.optionList.length, (i) {
                                  final additive = controller.optionList[i];
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              height: 40.h,
                                              margin:
                                                  EdgeInsets.only(right: 10.w),
                                              decoration: BoxDecoration(
                                                color: Tcolor.SECONDARY_S4,
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ReuseableText(
                                                        title: additive
                                                            .additiveName,
                                                        style: TextStyle(
                                                            fontSize: 22.sp,
                                                            color: Tcolor.White,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                      SizedBox(
                                                        width: 15.w,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .clearAdditives();
                                                        },
                                                        child: Icon(
                                                          HeroiconsOutline
                                                              .xMark,
                                                          color: Tcolor.White,
                                                          size: 32.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),

                    // const SizedBox(
                    //   height: 20,
                    // ),
                    GestureDetector(
                      onTap: () {
                        if (controller.additiveName.text.isNotEmpty &&
                            controller.additivePrice.text.isNotEmpty) {
                          int price = int.parse(controller.additivePrice.text);
                          AdditiveOption additives = AdditiveOption(
                              additiveName: controller.additiveName.text,
                              isAvailable: true,
                              price: price,
                              id: controller.generateId().toString());

                          controller.addAdditive = additives;
                          controller.additivePrice.text = "";
                          controller.additiveName.text = "";
                        } else {
                          Get.snackbar(
                              colorText: Tcolor.White,
                              backgroundColor: Tcolor.BACKGROUND_Regaular,
                              "Something went wrong",
                              "please fill all fields");
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            HeroiconsOutline.plus,
                            size: 32.sp,
                            color: Tcolor.PRIMARY_S4,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          ReuseableText(
                            title: "Add additive",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.sp,
                                color: Tcolor.PRIMARY_S4),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Container(
                          width: 130.w,
                          height: 5.h,
                          color: Tcolor.BORDER_Regular,
                        ),
                        Container(
                          width: 400.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: Tcolor.BACKGROUND_Dark,
                              borderRadius: BorderRadius.circular(30.r)),
                          child: Center(
                            child: ReuseableText(
                              title: "Or create from existing menu items",
                              style: TextStyle(
                                color: Tcolor.TEXT_Body,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 130.w,
                          height: 5.h,
                          color: Tcolor.BORDER_Regular,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ReuseableText(
                      title: "Menu item",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SetupField(
                            width: width,
                            sufixIcon: GestureDetector(
                              onTap: controller.optionList.isEmpty
                                  ? () {
                                      controller.clearTypes();
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return Container(
                                                decoration: BoxDecoration(
                                                    color: Tcolor.White,
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20.r),
                                                            topRight:
                                                                Radius.circular(
                                                                    20.r))),
                                                height: 1150.h,
                                                width: width,
                                                child: const MenuItem());
                                          });
                                    }
                                  : () {
                                      Get.rawSnackbar(
                                        message: "    Option is inactive",
                                        backgroundColor: Colors.grey[800]!,
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: EdgeInsets.only(
                                          bottom: 20, // distance from bottom
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.20,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                        ),
                                        borderRadius: 20,
                                        duration: const Duration(seconds: 3),
                                        animationDuration:
                                            const Duration(milliseconds: 300),
                                        isDismissible: true,
                                      );
                                    },
                              child: Icon(
                                HeroiconsOutline.chevronDown,
                                size: 28.sp,
                                color: Tcolor.TEXT_Label,
                              ),
                            ),
                            hintText: "Select items",
                            controller: controller.menuItem,
                            onTap: controller.optionList.isEmpty
                                ? () {
                                    controller.clearTypes();
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: Tcolor.White,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.r),
                                                    topRight:
                                                        Radius.circular(20.r))),
                                            height: 1150.h,
                                            width: width,
                                            child: const MenuItem(),
                                          );
                                        });
                                  }
                                : () {
                                    Get.rawSnackbar(
                                      message: "    Option is inactive",
                                      backgroundColor: Colors.grey[800]!,
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: EdgeInsets.only(
                                        bottom: 20, // distance from bottom
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.30,
                                      ),
                                      borderRadius: 20,
                                      duration: const Duration(seconds: 3),
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      isDismissible: true,
                                    );
                                  },
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          controller.types.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        controller.types.length, (i) {
                                      return Container(
                                        height: 40.h,
                                        margin: EdgeInsets.only(right: 10.w),
                                        decoration: BoxDecoration(
                                          color: Tcolor.SECONDARY_S4,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: ReuseableText(
                                              title: controller.types[i].title,
                                              style: TextStyle(
                                                  fontSize: 22.sp,
                                                  color: Tcolor.White,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
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
                              activeColor: const Color.fromRGBO(
                                  251, 178, 23, 1), // Active color
                              thumbColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors
                                      .white; // White thumb when active
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
                    // SizedBox(
                    //   height: 60.h,
                    // ),
                  ],
                ),
              )),
              Padding(
                padding: EdgeInsets.only(
                  left: 30.w,
                  right: 30.w,
                ),
                child: CustomButton(
                  title: "Add additive",
                  fontSize: 28.sp,
                  textColor: Tcolor.Text,
                  fontWeight: FontWeight.w500,
                  showArrow: false,
                  btnHeight: 80.h,
                  btnWidth: width,
                  raduis: 100.r,
                  btnColor: Tcolor.PRIMARY_Button_color_2,
                  onTap: () async {
                    // Your logic to add category
                    if (controller.additiveCategory.text.isNotEmpty &&
                        controller.optionList.isNotEmpty &&
                        controller.types.isEmpty) {
                      try {
                        // Ensure the input fields for min, max, and price are properly filled
                        int min =
                            int.tryParse(controller.minController.text) ?? 0;
                        int max =
                            int.tryParse(controller.maxController.text) ?? 0;
                        // Validate that no `additiveName` or `price` fields are empty
                        bool valid = true;
                        controller.optionList.forEach((additive) {
                          if (additive.additiveName.isEmpty ||
                              additive.price == 0) {
                            valid = false;
                          }
                        });

                        // Proceed if validation passes
                        if (valid) {
                          List<AdditiveOption> additives =
                              controller.optionList.map((additiveModel) {
                            return AdditiveOption(
                              price: additiveModel.price,
                              additiveName: additiveModel.additiveName,
                              isAvailable: additiveModel.isAvailable,
                              id: additiveModel.id,
                            );
                          }).toList();

                          // Create the model
                          CreateAdditiveModel model = CreateAdditiveModel(
                            restaurantId: restaurantId,
                            additiveTitle: controller.additiveCategory.text,
                            max: max,
                            min: min,
                            isAvailable: controller.isAvailable.value,
                            options: additives,
                          );

                          // Convert the model to JSON
                          String data = createAdditiveModelToJson(model);

                          // Call the function with the JSON data
                          int? statusCode =
                              await controller.createAdditiveFunction(
                                  data, widget.refetch as Function);
                          if (statusCode == 201) {
                            additives.clear();
                            widget.refetch?.call();
                            Get.back();
                          } else {
                            Get.rawSnackbar(
                              message: "something went wrong",
                              backgroundColor: Colors.grey[800]!,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: EdgeInsets.only(
                                bottom: 20, // distance from bottom
                                left: MediaQuery.of(context).size.width * 0.18,
                                right: MediaQuery.of(context).size.width * 0.25,
                              ),
                              borderRadius: 20,
                              duration: const Duration(seconds: 3),
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              isDismissible: true,
                            );
                          }
                        } else {
                          // Handle validation failure
                        }
                      } catch (e) {
                        // Handle any parsing errors or exceptions
                      }
                    } else if (controller.types.isNotEmpty &&
                        controller.additiveCategory.text.isNotEmpty &&
                        controller.optionList.isEmpty) {
                      int min =
                          int.tryParse(controller.minController.text) ?? 0;
                      int max =
                          int.tryParse(controller.maxController.text) ?? 0;
                      List<AdditiveOption> additives = [];

                      controller.types.forEach((additiveModel) {
                        additiveModel.options.forEach((option) {
                          additives.add(AdditiveOption(
                            price: option.price, // Map the price from Option
                            additiveName:
                                option.name, // Map the name from Option
                            isAvailable: true,
                            id: controller
                                .generateId()
                                .toString(), // Use the AdditiveModel's isAvailable status
                          ));
                        });
                      });

                      CreateAdditiveModel model = CreateAdditiveModel(
                        restaurantId: restaurantId,
                        additiveTitle: controller.additiveCategory.text,
                        max: max,
                        min: min,
                        isAvailable: controller.isAvailable.value,
                        options: additives,
                      );

                      // Convert the model to JSON
                      String data = createAdditiveModelToJson(model);
                      print("Request data: $data");

                      // Call the function with the JSON data
                      int? statusCode = await controller.createAdditiveFunction(
                          data, widget.refetch as Function);
                      if (statusCode == 201) {
                        controller.types.clear();
                        controller.additiveCategory.text = "";
                        controller.optionList.clear();
                        widget.refetch?.call();
                        Get.back();
                      } else {
                        Get.rawSnackbar(
                          message: "something went wrong",
                          backgroundColor: Colors.grey[800]!,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: EdgeInsets.only(
                            bottom: 20, // distance from bottom
                            left: MediaQuery.of(context).size.width * 0.18,
                            right: MediaQuery.of(context).size.width * 0.25,
                          ),
                          borderRadius: 20,
                          duration: const Duration(seconds: 3),
                          animationDuration: const Duration(milliseconds: 300),
                          isDismissible: true,
                        );
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
        Obx(() {
          if (controller.isLoading) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Dim background
                child: Center(
                  child: LottieBuilder.asset(
                    'assets/animation/loading_state.json', // Replace with your Lottie file path
                    width: 200.w,
                    height: 200.h,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
