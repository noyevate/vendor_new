import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/pack_field.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/create_dditive_controller.dart';
import 'package:vendor/controller/restaurant_menu_controller.dart';
import 'package:vendor/models/create_additive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class AddAdditives extends StatefulWidget {
  const AddAdditives({super.key});

  @override
  State<AddAdditives> createState() => _AddAdditivesState();
}

class _AddAdditivesState extends State<AddAdditives> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantMenuController(), permanent: true);
    final additiveController = Get.put(AdditiveController());

    final box = GetStorage();
    final restaurantId = box.read("restaurantId");
    print("resturantID: $restaurantId");

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
                      controller.clearAdditives();
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
            title: "Additive category",
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
            hintText: "e.g Big pack",
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
                    title: "Additive name",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.sp,
                        color: Tcolor.TEXT_Label),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  PackField(
                    width1: 400.w,
                    controller: controller.additiveName,
                    hintText: "e.g Big pack",
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                    title: "Price",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.sp,
                        color: Tcolor.TEXT_Label),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  PackField(
                    width1: 200.w,
                    controller: controller.additivePrice,
                    hintText: "e.g Big pack",
                    keyboardType: TextInputType.phone,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Obx(
            () => controller.optionList.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          List.generate(controller.optionList.length, (i) {
                        final additive = controller.optionList[i];
                        return Row(
                          children: [
                            Container(
                                height: 40.h,
                                margin: EdgeInsets.only(right: 10.w),
                                decoration: BoxDecoration(
                                  color: Tcolor.SECONDARY_S4,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ReuseableText(
                                          title: additive.additiveName,
                                          style: TextStyle(
                                              fontSize: 22.sp,
                                              color: Tcolor.White,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.clearAdditives();
                                          },
                                          child: Icon(
                                            HeroiconsOutline.xMark,
                                            color: Tcolor.White,
                                            size: 32.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        );
                      }),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          SizedBox(
            height: 40.h,
          ),
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
                  title: "Add another additive",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.sp,
                      color: Tcolor.PRIMARY_S4),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableText(
                title: "Mark item in stock",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 28.sp,
                    color: Tcolor.TEXT_Label),
              ),
              Obx(
                () => Transform.scale(
                  scale: 0.6,
                  child: Switch.adaptive(
                    value: controller.isAvailable.value,
                    onChanged: controller.toggleAdditiveSwitch,
                    activeColor:
                        const Color.fromRGBO(251, 178, 23, 1), // Active color
                    thumbColor: MaterialStateProperty.resolveWith((states) {
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
          const Spacer(),
          GestureDetector(
            onTap: () async {
              if (controller.additiveCategory.text.isNotEmpty &&
                  controller.optionList.isNotEmpty) {
                try {
                  bool valid = true;

                  // Validate `additiveName` and `price`
                  controller.optionList.forEach((additive) {
                    if (additive.additiveName.isEmpty || additive.price == 0) {
                      valid = false;
                    }
                  });

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
                      max: 10,
                      min: 1,
                      isAvailable: controller.isAvailable.value,
                      options: additives,
                    );

                    // Convert the model to JSON
                    String data = createAdditiveModelToJson(model);
                    print(data);

                    // Call the function and await the response
                    additiveController.createAdditiveFunction(data, () {});
                  } else {
                    // Handle validation failure
                    Get.snackbar(
                      "Invalid Input",
                      "Please ensure all fields are correctly filled.",
                      colorText: Tcolor.Text,
                      backgroundColor: Tcolor.Secondary_Base,
                    );
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              }
            },
            child: CustomButton(
              title: "Add category",
              fontSize: 28.sp,
              textColor: Tcolor.Text,
              fontWeight: FontWeight.w500,
              showArrow: false,
              btnHeight: 80.h,
              btnWidth: width,
              raduis: 100.r,
              btnColor: Tcolor.PRIMARY_Button_color_2,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
        ],
      ),
    );
  }
}
