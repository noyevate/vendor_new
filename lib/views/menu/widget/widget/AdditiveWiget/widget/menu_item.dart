import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custim_checkbox.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/create_dditive_controller.dart';
import 'package:vendor/hooks/fetch_resaurant_additives.dart';
import 'package:vendor/models/additive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class MenuItem extends HookWidget {
  const MenuItem({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCategories("668552324409ef9c2bb165eb");
    final List<AdditiveModel> restaurantFood = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;

    // Access the AdditiveController
    final AdditiveController additiveController =
        Get.find<AdditiveController>();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text("Error: ${error.toString()}"));
    }

    if (restaurantFood.isEmpty) {
      return Center(
        child: ReuseableText(
          title: "No food items available.",
          style: TextStyle(fontSize: 18.sp, color: Tcolor.TEXT_Label),
        ),
      );
    }

    final checkedItems = useState<List<bool>>(
        List.generate(restaurantFood.length, (index) => false));

    return Container(
  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
  decoration: BoxDecoration(
    color: Tcolor.White,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReuseableText(
            title: "Select menu items",
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
                  Get.back();
                  additiveController.types.isNotEmpty
                      ? additiveController.menuItem.text =
                          "${additiveController.types.length} Selected Items"
                      : additiveController.menuItem.text = "";
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
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(restaurantFood.length, (index) {
              final AdditiveModel food = restaurantFood[index];
              return Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
                      child: CustomCircularCheckbox(
                        value: checkedItems.value[index],
                        onChanged: (bool? value) {
                          checkedItems.value = List<bool>.from(checkedItems.value)
                            ..[index] = value ?? false;
                          if (value == true) {
                            additiveController.setTypes = food;
                          } else {
                            additiveController.types.remove(food);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 30.w), // Fixed space between checkbox and text
                    Expanded( // Ensures the text takes the remaining space
                      child: ReuseableText(
                        title: food.title,
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: Tcolor.Text,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    ],
  ),
);

  }
}
