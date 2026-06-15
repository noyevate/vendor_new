import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/loading_lottie.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/enty_point.dart';
import 'package:vendor/hooks/fetch_user_restaurant.dart';
import 'package:vendor/models/fetch_user_restaurant.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/business_insight.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/operating_hours.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/payout_details.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/restaurant_details.dart';
import 'package:vendor/views/restaurant/widget/restaurant_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:get_storage/get_storage.dart';

class RestaurantProfile extends HookWidget {
  const RestaurantProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var userId = box.read("userID");

    final hookResult = useFetchUserRestaurant(userId);
    final FetchUserRestaurantModel? userRestaurant = hookResult.data;
    final isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;

    // Keep the icon2 state as nullable, initially null, and update it when data is available
    final iconState = useState<IconData?>(null);
    final iconState2 = useState<IconData?>(null);

    // State to show the Lottie animation
    final showLoadingAnimation = useState(false);

    useEffect(() {
      // When loading completes, set icon2 based on the presence of userRestaurant data
      if (!isLoading && userRestaurant != null) {
        iconState.value = HeroiconsSolid.checkCircle;
      } else {
        const SizedBox.shrink();
      }

      if (!isLoading &&
          userRestaurant != null &&
          userRestaurant.time.isNotEmpty) {
        iconState2.value = HeroiconsSolid.checkCircle;

        showLoadingAnimation.value = true;

        // Delay to let the animation play, then navigate
        Future.delayed(const Duration(seconds: 4), () {
          showLoadingAnimation.value = false; // Hide animation
          Get.to(() => const MainScreen(), // Replace with your new page widget
              transition: Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 700));
        });
      } else {
        const SizedBox.shrink();
      }

      return null;
    }, [isLoading, userRestaurant]);

    return showLoadingAnimation.value
        ? const Center(
            child: LoadingLottie(),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: const PageTitle(
                    title: "Restaurant profile",
                  ),
                ),
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
                        if (userRestaurant != null) {
                          Get.snackbar(
                            'Notice',
                            'User already created a restaurant.',
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10), // Smaller margin
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5), // Compact padding
                            borderRadius:
                                8, // Rounded corners for a sleeker look
                            // backgroundColor: Colors.black
                            // .withOpacity(0.7), // Transparent background
                            colorText: Tcolor.PRIMARY_S4,
                            barBlur: 10, // Adds a blur effect
                            duration: const Duration(
                                seconds: 6), // Reduce display time
                          );
                        } else {
                          Get.to(
                            () => const RestaurantDetails(),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 700),
                          );
                        }
                      },
                      child: RestaurantProfileTile(
                        icon: HeroiconsOutline.buildingStorefront,
                        title: "Restaurant details",
                        icon2: iconState.value, // Set icon2 to the state value
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
                        Get.to(() => const OperatingHours(),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 700));
                      },
                      child: RestaurantProfileTile(
                        icon: HeroiconsOutline.clock,
                        title: "Operating hours",
                        icon2: iconState2.value,
                        onTap: () {
                          Get.to(() => const OperatingHours(),
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
                        Get.to(() => const BusinessInsight(),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 700));
                      },
                      child: RestaurantProfileTile(
                        icon: HeroiconsOutline.chartBarSquare,
                        title: "Business insight",
                        onTap: () {
                          Get.to(() => const BusinessInsight(),
                              transition: Transition.leftToRightWithFade,
                              duration: const Duration(milliseconds: 700));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
