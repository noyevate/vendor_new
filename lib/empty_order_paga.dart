import 'package:get_storage/get_storage.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/operating_hours_controller.dart';
import 'package:vendor/controller/operating_hours_controller_new.dart';
import 'package:vendor/controller/payout_controller.dart';
import 'package:vendor/models/fetch_user_restaurant.dart';
import 'package:vendor/enty_point.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/operating_hours.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/payout_details.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/restaurant_details.dart';
import 'package:vendor/views/restaurant/widget/restaurant_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import 'controller/restaurant_setup_controller.dart';

class EmptyOrderPage extends StatelessWidget {
  const EmptyOrderPage({
    super.key,
    this.restaurant,
  });

  final LoginResponseModel? restaurant;

  @override
  Widget build(BuildContext context) {
    final restaurantSetupController = Get.put(RestaurantSetupController());
    final operatingHoursController = Get.put(OperatingHoursControllerNew());
    final payoutDetailsController = Get.put(PayoutController());
    var box = GetStorage();
    if (restaurant != null && restaurant!.ownedRestaurant != null) {
      restaurantSetupController.isRestaurant.value = true;
    }

    if (restaurant != null &&
        restaurant!.ownedRestaurant != null &&
        (restaurant!.ownedRestaurant?.accountNumber?.isNotEmpty ?? false)) {
      payoutDetailsController.isAccountDetails.value = true;
    }

    if (restaurant != null &&
        restaurant != null &&
        restaurant!.ownedRestaurant != null &&
        restaurant!.ownedRestaurant!.time != null) {
      operatingHoursController.isOperatingHours.value = true;
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReuseableText(
                  title: "Order",
                  style: TextStyle(
                      color: Tcolor.Text,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        //
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        color: Tcolor.BACKGROUND_Regaular,
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            ReuseableText(
              title: "Set up your restaurant",
              style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.w700,
                  color: Tcolor.Text),
            ),
            SizedBox(
              height: 20.h,
            ),
            ReuseableText(
              title: "Complete your restaurant setup to start receiving ",
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text),
            ),
            ReuseableText(
              title: "customer orders.",
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text),
            ),
            SizedBox(
              height: 40.h,
            ),
            Obx(() {
              print(
                  "isRestaurant: ${restaurantSetupController.isRestaurant.value}");
              final bool restaurantIsSetup =
                  restaurant?.ownedRestaurant != null ||
                      restaurantSetupController.isRestaurant.value;

              return GestureDetector(
                onTap: !restaurantIsSetup
                    ? () {
                        Get.to(
                          () => const RestaurantDetails(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 700),
                        );
                      }
                    : () {
                        print("already set up");
                      },
                child: Container(
                  height: 100.h,
                  width: width,
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  decoration: BoxDecoration(
                    color: restaurantIsSetup
                        ? Tcolor.SECONDARY_T2
                        : Tcolor.BACKGROUND_Dark,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: RestaurantProfileTile(
                    icon2:
                        restaurantIsSetup ? HeroiconsSolid.checkCircle : null,
                    icon: HeroiconsOutline.buildingStorefront,
                    title: "Restaurant details",
                  ),
                ),
              );
            }),

            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return GestureDetector(
                onTap: restaurantSetupController.isRestaurant.value ||
                        restaurant != null ||
                        !operatingHoursController.isOperatingHours.value
                    ? () {
                        Get.to(
                          () => const OperatingHours(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 700),
                        );
                      }
                    : () {
                        print(restaurantSetupController.isRestaurant.value);
                      },
                child: Container(
                  height: 100.h,
                  width: width,
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  decoration: BoxDecoration(
                      color: (restaurant != null &&
                                  restaurant!.ownedRestaurant != null &&
                                  restaurant!.ownedRestaurant!.time != null) ||
                              operatingHoursController.isOperatingHours.value
                          ? Tcolor.SECONDARY_T2
                          : Tcolor.BACKGROUND_Dark,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: RestaurantProfileTile(
                    icon: HeroiconsOutline.clock,
                    icon2: (restaurant != null &&
                                restaurant!.ownedRestaurant != null &&
                                restaurant!.ownedRestaurant!.time != null) ||
                            operatingHoursController.isOperatingHours.value
                        ? HeroiconsSolid.checkCircle
                        : null,
                    title: "Operating hours",
                  ),
                ),
              );
            }),

            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => GestureDetector(
                onTap: payoutDetailsController.isAccountDetails.value == false
                    ? () {
                        print(
                            "accountNumber: ${restaurant?.ownedRestaurant?.accountNumber}");
                        print(
                            "isAccountDetails: ${payoutDetailsController.isAccountDetails.value}");
                        print(payoutDetailsController.isAccountDetails.value);
                        Get.to(
                          () => const PayoutDetails(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 700),
                        );
                      }
                    : null,
                child: Container(
                  height: 100.h,
                  width: width,
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  decoration: BoxDecoration(
                      color: (restaurant != null &&
                                  restaurant!.ownedRestaurant != null &&
                                  (restaurant!.ownedRestaurant?.accountNumber
                                          ?.isNotEmpty ??
                                      false)) ||
                              payoutDetailsController.isAccountDetails.value
                          ? Tcolor.SECONDARY_T2
                          : Tcolor.BACKGROUND_Dark,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: RestaurantProfileTile(
                    icon: HeroiconsOutline.banknotes,
                    icon2: (restaurant != null &&
                                restaurant!.ownedRestaurant != null &&
                                (restaurant!.ownedRestaurant?.accountNumber
                                        ?.isNotEmpty ??
                                    false)) ||
                            payoutDetailsController.isAccountDetails.value
                        ? HeroiconsSolid.checkCircle
                        : null,
                    title: "Pay out details",
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
            // GestureDetector(
            //   onTap: restaurant == null ?() {
            //     Get.to(
            //       () => const MainScreen(),
            //       arguments: 2,
            //       transition: Transition.leftToRightWithFade,
            //       duration: const Duration(milliseconds: 700),
            //     );
            //   } : null,
            //   child: Container(
            //     height: 100.h,
            //     width: width,
            //     padding: EdgeInsets.only(left: 30.w, right: 30.w),
            //     decoration: BoxDecoration(
            //       color: restaurant != null && restaurant!.restaurant != null && restaurant!.restaurant!.time.isNotEmpty
            //           ? Tcolor.SECONDARY_T2
            //           : Tcolor.BACKGROUND_Dark,
            //       borderRadius: BorderRadius.circular(30.r),
            //     ),
            //     child: RestaurantProfileTile(
            //       icon: HeroiconsOutline.puzzlePiece,
            //       icon2: restaurant != null && restaurant!.restaurant != null && restaurant!.restaurant!.foods.isNotEmpty
            //           ? HeroiconsSolid.checkCircle
            //           : null,
            //       title: "Menu",
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 400.h,
            ),
            Obx(() {
              final isAccountDetails =
                  payoutDetailsController.isAccountDetails.value;
              final isOperatingHours =
                  operatingHoursController.isOperatingHours.value;
              final isRestaurant = restaurantSetupController.isRestaurant.value;

              // FIXED: Safely check for null values without using the "!" operator
              final hasFoods = restaurant
                      ?.ownedRestaurant?.restaurantCategories?.isNotEmpty ??
                  false;
              final hasTime =
                  restaurant?.ownedRestaurant?.time != null ?? false;

              final isEnabled =
                  isAccountDetails && isOperatingHours && isRestaurant;

              return isEnabled
                  ? CustomButton(
                      title: "Request verification",
                      textColor:
                          hasFoods && hasTime ? Tcolor.Text : Tcolor.TEXT_Label,
                      btnColor: hasFoods && hasTime
                          ? Tcolor.PRIMARY_Button_color_2
                          : Tcolor.PRIMARY_T4,
                      btnWidth: MediaQuery.of(context).size.width / 1.1,
                      btnHeight: 96.h,
                      raduis: 100.r,
                      fontSize: 32.sp,
                      showArrow: false,
                    )
                  : const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
