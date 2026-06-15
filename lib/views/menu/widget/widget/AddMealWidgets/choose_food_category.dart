import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/restaurant_menu_controller.dart';
import 'package:vendor/hooks/fetch_all_category.dart';
import 'package:vendor/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class FoodCategory extends HookWidget {
  const FoodCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAllCategories();
    final List<CategorySearchModel> foodCategories = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
    print(foodCategories.length);
    final controller = Get.put(RestaurantMenuController(), permanent: true);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableText(
                title: "Select food category",
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
          SizedBox(height: 30.h),
          Expanded(
            // 👈 Add this to take up the rest of the space
            child: isLoading
                ? Center(child: const CircularProgressIndicator())
                : error != null
                    ? Center(
                        child: ReuseableText(
                          title: "An error occurred",
                          style: TextStyle(
                            fontSize: 25.sp,
                            color: Tcolor.TEXT_Placeholder,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children:
                              List.generate(foodCategories.length, (index) {
                            final foodCategory = foodCategories[index];
                            return GestureDetector(
                              onTap: () {
                                controller.foodCategory.value =
                                    foodCategory.title;
                                controller.foodCategoryId.value =
                                    foodCategory.id;
                                Get.back();
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 40.h, bottom: 40.h),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: ReuseableText(
                                        title: foodCategory.title,
                                        style: TextStyle(
                                          color: Tcolor.Text,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
