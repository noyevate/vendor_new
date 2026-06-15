// ignore_for_file: prefer_const_constructors

import 'package:vendor/common/page_title.dart';
import 'package:vendor/hooks/fetch_user_restaurant.dart';
import 'package:vendor/models/fetch_user_restaurant.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/views/profile/widget/busines_insights/business_insight.dart';
import 'package:vendor/views/profile/widget/restaurant_profile/restaurant_details2.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/business_insight.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/operating_hours.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/payout_details.dart';
import 'package:vendor/views/profile/widget/restaurant_profile2.dart';
import 'package:vendor/views/restaurant/widget/restaurant_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class RestaurantProfile2 extends StatelessWidget {
  const RestaurantProfile2({super.key, this.userRestaurant});
  
  final LoginResponseModel? userRestaurant;
  

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var userId = box.read("userID");



    return   Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: const PageTitle(title: "Restaurant profile",),
              ),
            )
          ],
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.sp,
              ),
              GestureDetector(
                onTap: () {
                    print(userRestaurant!.ownedRestaurant!.imageUrl);
                    Get.to(
                      () => RestaurantDetails2(restaurant: userRestaurant,),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(milliseconds: 700),
                    );
                  
                },
                child: const RestaurantProfileTile(
                  icon: HeroiconsOutline.buildingStorefront,
                  title: "Restaurant details",
                  // onTap: () {
                  //   Get.to(
                  //       () => userRestaurant == null
                  //           ? null
                  //           : RestaurantDetails(
                  //               refetch: refetch,
                  //             ),
                  //       transition: Transition.leftToRightWithFade,
                  //       duration: const Duration(milliseconds: 700));
                  // },
                ),
              ),
              SizedBox(
                height: 50.sp,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() =>  OperatingHours(restaurant: userRestaurant,),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(milliseconds: 700));
                },
                child: RestaurantProfileTile(
                  icon: HeroiconsOutline.clock,
                  title: "Operating hours",
                  onTap: () {
                    Get.to(() =>  OperatingHours(restaurant: userRestaurant,),
                        transition: Transition.leftToRightWithFade,
                        duration: const Duration(milliseconds: 700));
                  },
                ),
              ),
              SizedBox(
                height: 50.sp,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const PayoutDetails(),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(milliseconds: 700));
                },
                child: RestaurantProfileTile(
                  icon: HeroiconsOutline.banknotes,
                  title: "Pay out details",
                  onTap: () {
                    Get.to(() => const PayoutDetails(),
                        transition: Transition.leftToRightWithFade,
                        duration: const Duration(milliseconds: 700));
                  },
                ),
              ),
              SizedBox(
                height: 50.sp,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() =>  RestaurantBusinessInsight(restaurant: userRestaurant,),
                      transition: Transition.leftToRight,
                      duration: const Duration(milliseconds: 700));
                },
                child: RestaurantProfileTile(
                  icon: HeroiconsOutline.chartBarSquare,
                  title: "Business insight",
                  // onTap: () {
                  //   Get.to(() => const RestaurantBusinessInsight(),
                  //       transition: Transition.leftToRightWithFade,
                  //       duration: const Duration(milliseconds: 700));
                  // },
                ),
              ),

              SizedBox(
                height: 50.sp,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const BusinessInsight(),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(milliseconds: 700));
                },
                child: RestaurantProfileTile(
                  icon: HeroiconsOutline.arrowsRightLeft,
                  title: "Transaction history",
                  onTap: () {
                    Get.to(() => const BusinessInsight(),
                        transition: Transition.leftToRightWithFade,
                        duration: const Duration(milliseconds: 700));
                  },
                ),
              ),
              // ReuseableText(title: restaurant!.id, style: TextStyle(fontSize: 30, color: Tcolor.Text))
            ],
          ),
        ),
      ),
    );
  }
}