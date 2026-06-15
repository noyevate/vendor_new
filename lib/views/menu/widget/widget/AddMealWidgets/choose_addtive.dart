import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custim_checkbox.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/restaurant_menu_controller.dart';
import 'package:vendor/hooks/fetch_additives.dart';
import 'package:vendor/hooks/fetch_packs.dart';
import 'package:vendor/models/fetch_additive_model.dart';
import 'package:vendor/models/fetch_packs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class ChooseAdditive extends HookWidget {
  const ChooseAdditive({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final restaurantId = box.read("restaurantId");
    print("resturantID: $restaurantId");

    final hookResult = useFetchAllAdditives(restaurantId);
    final List<FetchAdditiveModel> restaurantAdditive = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
    final refetch = hookResult.refetch;
    final controller = Get.put(RestaurantMenuController(), permanent: true);

    // if (isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    // if (error != null) {
    //   return Center(child: Text("Error: ${error.toString()}"));
    // }

    // if (restaurantAdditive.isEmpty) {
    //   return Center(
    //     child: ReuseableText(
    //       title: "No food items available.",
    //       style: TextStyle(fontSize: 18.sp, color: Tcolor.TEXT_Label),
    //     ),
    //   );
    // }

    // if (restaurantAdditive.isEmpty) {

    // }

    // final checkedItems = useState<List<bool>>(
    //     List.generate(restaurantAdditive.length, (index) => false));

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        color: Tcolor.White,
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableText(
                title: "Select additive categories",
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
                      controller.updateAdditiveItem();
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
          SizedBox(height: 30.h), // Spacing below the title
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
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
                    : restaurantAdditive.isEmpty
                        ? Center(
                            child: ReuseableText(
                              title: "No additive created",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Tcolor.TEXT_Placeholder,
                                fontSize: 25.sp,
                              ),
                            ),
                          )
                        : restaurantAdditive.isNotEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                      restaurantAdditive.length, (index) {
                                    final checkedItems = useState<List<bool>>(
                                        List.generate(restaurantAdditive.length,
                                            (index) => false));
                                    final FetchAdditiveModel additive =
                                        restaurantAdditive[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.h, bottom: 10.h),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 30.h, bottom: 20.h),
                                            child: CustomCircularCheckbox(
                                              value: checkedItems.value[index],
                                              onChanged: (bool? value) {
                                                checkedItems.value =
                                                    List<bool>.from(
                                                        checkedItems.value)
                                                      ..[index] =
                                                          value ?? false;
                                                if (value == true) {
                                                  controller.setAdditiveTypes =
                                                      additive;
                                                } else {
                                                  controller.clearTypes();
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 30.w),
                                          Expanded(
                                            child: ReuseableText(
                                              title: additive.additiveTitle,
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
                              )
                            : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
