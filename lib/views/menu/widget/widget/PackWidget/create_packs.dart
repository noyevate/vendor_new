import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/pack_field.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/pack_controller.dart';
import 'package:vendor/models/pack_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CreatePack extends StatefulWidget {
  const CreatePack({super.key, this.refetch});
  final Function()? refetch;

  @override
  State<CreatePack> createState() => _CreatePackState();
}

class _CreatePackState extends State<CreatePack> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PackController());
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
                      title: "Add pack",
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReuseableText(
                        title: "Pack name",
                        style: TextStyle(
                          color: Tcolor.TEXT_Label,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      PackField(
                        hintText: "e.g Ewa agoyin",
                        controller: controller.packNameController,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      ReuseableText(
                        title: "Pack description",
                        style: TextStyle(
                          color: Tcolor.TEXT_Label,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      PackField(
                        hintText: "e.g Ewa agoyin",
                        controller: controller.packDescriptionController,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      ReuseableText(
                        title: "Price",
                        style: TextStyle(
                          color: Tcolor.TEXT_Label,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      PackField(
                        hintText: "",
                        prefix: Text(
                          "₦  ",
                          style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        controller: controller.packPriceController,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: EdgeInsets.only(
                    left: 30.w,
                    right: 30.w,
                  ),
                  child: CustomButton(
                      title: "Add pack",
                      fontSize: 28.sp,
                      textColor: Tcolor.Text,
                      fontWeight: FontWeight.w500,
                      showArrow: false,
                      btnHeight: 80.h,
                      btnWidth: width,
                      raduis: 100.r,
                      onTap: controller.isFormFilled.value
                          ? () async {
                            FocusScope.of(context).unfocus();
                              if (controller
                                      .packNameController.text.isNotEmpty &&
                                  controller.packDescriptionController.text
                                      .isNotEmpty &&
                                  controller
                                      .packPriceController.text.isNotEmpty) {
                                int price = int.tryParse(
                                        controller.packPriceController.text) ??
                                    0;
                                final PackModel model = PackModel(
                                    restaurantId: restaurantId,
                                    packName:
                                        controller.packNameController.text,
                                    packDescription: controller
                                        .packDescriptionController.text,
                                    price: price,
                                    isAvailable: true);

                                String data = packModelToJson(model);
                                int? statusCode =
                                    await controller.createPackFunction(data, widget.refetch as Function);
                                if (statusCode == 201) {
                                  widget.refetch?.call();
                                  // print("Can go back: ${Get.previousRoute.isNotEmpty}");

                                  Get.back();
                                } else {
                                  Get.rawSnackbar(
                                    message: "something went wrong",
                                    backgroundColor: Colors.grey[800]!,
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: EdgeInsets.only(
                                      bottom: 20, // distance from bottom
                                      left: MediaQuery.of(context).size.width *
                                          0.18,
                                      right: MediaQuery.of(context).size.width *
                                          0.25,
                                    ),
                                    borderRadius: 20,
                                    duration: const Duration(seconds: 3),
                                    animationDuration:
                                        const Duration(milliseconds: 300),
                                    isDismissible: true,
                                  );
                                }
                              }
                            }
                          : null,
                      btnColor: controller.isFormFilled.value
                          ? Tcolor.PRIMARY_Button_color_2
                          : Tcolor.PRIMARY_T4),
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
