import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/hooks/fetch_restaurant_food.dart';
import 'package:vendor/models/filter_by_restaurant_category_model.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/views/menu/widget/widget/AddMealWidgets/meal_tile.dart';
import 'package:vendor/views/menu/widget/widget/add_food.dart';
import 'package:vendor/views/menu/widget/widget/add_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MealsPage extends HookWidget {
  const MealsPage({super.key, this.restaurantProfile});
  final LoginResponseModel? restaurantProfile;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var restaurantId = box.read("restaurantId") ?? "12345";

    final hookResult = useFetchRestaurantFoods(restaurantId);
    final List<RestaurantCategoryModel> restaurantFoods = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
    final refetch = hookResult.refetch;

    if (isLoading) {
      return Center(
        child: ReuseableText(
          title: "Loading",
          style: TextStyle(
            fontSize: 32.sp,
            color: Tcolor.Primary_New,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    if (restaurantFoods.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/empty_meals.png",
              width: 300.w,
              height: 300.h,
            ),
            SizedBox(
              height: 30.h,
            ),
            ReuseableText(
              title: "Add your first meal to get",
              style: TextStyle(
                color: Tcolor.TEXT_Body,
                fontSize: 28.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            ReuseableText(
              title: "started!",
              style: TextStyle(
                color: Tcolor.TEXT_Body,
                fontSize: 28.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 30.h),
            // GestureDetector(
            //   onTap: () {
            //     Get.to(() => AddMealWidget(
            //           restaurant: restaurantProfile,
            //         ));
            //   },
            //   child: const AddFoodWidget(title: 'Add meal'),
            // )
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 120.h), // ensure space for FAB
        itemCount: restaurantFoods.length,
        itemBuilder: (context, i) {
          var food = restaurantFoods[i];
          return Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: MealTile(
              food: food,
              refetch: refetch,
            ),
          );
        },
      ),
    );
  }
}
