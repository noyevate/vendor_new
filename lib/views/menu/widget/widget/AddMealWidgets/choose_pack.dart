import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/restaurant_menu_controller.dart';
import 'package:vendor/hooks/fetch_packs.dart';
import 'package:vendor/models/fetch_packs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class ChoosePack extends HookWidget {
  const ChoosePack({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final restaurantId = box.read("restaurantId");
    print("restaurantID: $restaurantId");
    final hookResult = useFetchAllPacks(restaurantId);
    final List<FetchPackModel> packs = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
    final refetch = hookResult.refetch;
    final controller = Get.put(RestaurantMenuController(), permanent: true);

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
                title: "Select pack",
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
                      controller.clearPacks();
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
                ? Center(
                    child: CircularProgressIndicator()) // Center the loader
                : packs.isEmpty
                    ? Center(
                        child: ReuseableText(
                          title: "No packs available",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400,
                            color: Tcolor.TEXT_Placeholder,
                          ),
                        ),
                      )
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
                              children: List.generate(packs.length, (index) {
                                final FetchPackModel pack = packs[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Update observable value
                                    Get.back();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 40.h,
                                        bottom: 40.h), // Vertical padding
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.setTypes = pack;
                                              controller.pack.text =
                                                  "${pack.packName}";
                                              Get.back();
                                            },
                                            child: ReuseableText(
                                              title: pack.packName,
                                              style: TextStyle(
                                                color: Tcolor.Text,
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
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
