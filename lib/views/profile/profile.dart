import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/login_controller.dart';
import 'package:vendor/controller/profile_restaurant_setup.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/views/profile/widget/awiting_verification.dart';
import 'package:vendor/views/profile/widget/help_support.dart';
import 'package:vendor/views/profile/widget/privacy_policy.dart';
import 'package:vendor/views/profile/widget/profile_details.dart';
import 'package:vendor/views/profile/widget/restaurant_profile2.dart';
import 'package:vendor/views/profile/widget/terms_of_use.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/operating_hours.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/restaurant_details.dart';
import 'package:vendor/views/restaurant/widget/restaurant_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.restaurantProfile});

  final LoginResponseModel? restaurantProfile;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isAwaitingVerification = false; // Tracks which content to show

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final profileController = Get.put(RestaurantSetupController2());
    profileController.restaurant_name.value =
        widget.restaurantProfile!.ownedRestaurant!.title;
    profileController.restaurant_address.value =
        widget.restaurantProfile!.ownedRestaurant!.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: ReuseableText(
                  title: 'Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 40.sp,
                    color: Tcolor.Text,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    height: 190.h,
                    width: width,
                    decoration: BoxDecoration(
                      color: Tcolor.SECONDARY_T2,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 140.h,
                          width: 120.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.r),
                            child: CachedNetworkImage(
                              imageUrl: widget
                                  .restaurantProfile!.ownedRestaurant!.logoUrl,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(
                                  Ionicons
                                      .fast_food_outline, // Or any other appropriate icon
                                  color: Tcolor.Text_Secondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 35.h,
                            ),
                            SizedBox(
                              width: 420.w,
                              child: Obx(
                                () => Text(
                                  profileController.restaurant_name.value,
                                  // maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 40.sp,
                                    color: Tcolor.Text,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            SizedBox(
                                width: 420.w,
                                child: Obx(
                                  () => ReuseableText(
                                    title: profileController
                                        .restaurant_address.value,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 28.sp,
                                      color: Tcolor.TEXT_Label,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                )),
                            SizedBox(
                              height: 15.w,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 40.sp,
                                  color: Tcolor.Primary_New,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ReuseableText(
                                  title: widget.restaurantProfile!
                                      .ownedRestaurant!.rating
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Tcolor.Text,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  if (widget.restaurantProfile!.ownedRestaurant!.verification !=
                      "Verified")
                    _isAwaitingVerification
                        ? const AwaitingVerification() // Show AwaitingVerification
                        : _buildAccountSetupContainer(), // Show original container

                  SizedBox(
                    height: 50.h,
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.to(
                          () => RestaurantProfile2(
                                userRestaurant: widget.restaurantProfile,
                              ),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 700));
                    },
                    child: RestaurantProfileTile(
                      icon: HeroiconsOutline.buildingStorefront,
                      title: "Restaurant profile",
                      onTap: () {
                        Get.to(
                            () => RestaurantProfile2(
                                  userRestaurant: widget.restaurantProfile,
                                ),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 700));
                      },
                    ),
                  ),

                  SizedBox(
                    height: 50.h,
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ProfileDetails(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 700));
                    },
                    child: RestaurantProfileTile(
                      icon: HeroiconsOutline.userCircle,
                      title: "Profile details",
                      onTap: () {
                        Get.to(() => const ProfileDetails(),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 700));
                      },
                    ),
                  ),

                  SizedBox(
                    height: 50.h,
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.to(() => const HelpSupport(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 700));
                    },
                    child: RestaurantProfileTile(
                      icon: HeroiconsOutline.questionMarkCircle,
                      title: "Help and Support",
                      onTap: () {
                        Get.to(() => const HelpSupport(),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 700));
                      },
                    ),
                  ),

                  SizedBox(
                    height: 50.h,
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.to(() => const PrivacyPolicy(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 700));
                    },
                    child: RestaurantProfileTile(
                      icon: HeroiconsOutline.documentText,
                      title: "Privacy policy",
                      onTap: () {
                        Get.to(() => const PrivacyPolicy(),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 700));
                      },
                    ),
                  ),

                  SizedBox(
                    height: 50.h,
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.to(() => const TermsOfUse(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 700));
                    },
                    child: RestaurantProfileTile(
                      icon: HeroiconsOutline.documentText,
                      title: "Terms of use",
                      onTap: () {
                        Get.to(() => const TermsOfUse(),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 700));
                      },
                    ),
                  ),

                  SizedBox(
                    height: 50.h,
                  ),

                  SizedBox(
                    height: 200.h,
                  ),

                  GestureDetector(
                    onTap: () {
                      controller.logout();
                    },
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: width / 3,
                          ),
                          Icon(HeroiconsOutline.arrowLeftEndOnRectangle,
                              color: Tcolor.ERROR_Reg, size: 40.sp),
                          SizedBox(
                            width: 20.w,
                          ),
                          ReuseableText(
                              title: "Logout",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 28.sp,
                                  color: Tcolor.ERROR_Reg)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 200.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSetupContainer() {
    return Container(
      padding:
          EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h, bottom: 30.h),
      height: 522.h,
      width: width,
      decoration: BoxDecoration(
          color: Tcolor.BACKGROUND_Regaular,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Tcolor.BORDER_Light)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReuseableText(
            title: "Account set-up",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
                color: Tcolor.Text),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const RestaurantDetails(),
                  transition: Transition.leftToRightWithFade,
                  duration: const Duration(milliseconds: 700));
            },
            child: RestaurantProfileTile(
              icon: widget.restaurantProfile != null
                  ? HeroiconsSolid.checkCircle
                  : HeroiconsOutline.buildingStorefront,
              title: "Restaurant details",
              color3: Tcolor.Secondary_S2,
              onTap: () {
                Get.to(() => const RestaurantDetails(),
                    transition: Transition.leftToRightWithFade,
                    duration: const Duration(milliseconds: 700));
              },
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const OperatingHours(),
                  transition: Transition.leftToRightWithFade,
                  duration: const Duration(milliseconds: 700));
            },
            child: RestaurantProfileTile(
              icon: widget.restaurantProfile!.ownedRestaurant!.time != null
                  ? HeroiconsSolid.checkCircle
                  : HeroiconsOutline.buildingStorefront,
              title: "Operating hours",
              icon2: widget.restaurantProfile!.ownedRestaurant!.time != null
                  ? HeroiconsMini.checkBadge
                  : null,
              color3: widget.restaurantProfile!.ownedRestaurant!.time != null
                  ? Tcolor.Secondary_S2
                  : Tcolor.TEXT_Label,
              onTap: () {
                Get.to(() => const OperatingHours(),
                    transition: Transition.leftToRightWithFade,
                    duration: const Duration(milliseconds: 700));
              },
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              // Get.to(() =>  const OperatingHours(),
              //     transition: Transition.leftToRightWithFade,
              //     duration: const Duration(milliseconds: 700));
            },
            child: RestaurantProfileTile(
              icon: widget.restaurantProfile!.ownedRestaurant!.time != null
                  ? HeroiconsSolid.checkCircle
                  : HeroiconsOutline.buildingStorefront,
              title: "Pay out details",
              // icon2:  restaurantProfile!.time.isEmpty ? HeroiconsMini.checkBadge : null,
              color3: Tcolor.TEXT_Label,
              onTap: () {
                // Get.to(() => const OperatingHours(),
                //     transition: Transition.leftToRightWithFade,
                //     duration: const Duration(milliseconds: 700));
              },
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const OperatingHours(),
                  transition: Transition.leftToRightWithFade,
                  duration: const Duration(milliseconds: 700));
            },
            child: RestaurantProfileTile(
              icon: widget.restaurantProfile!.ownedRestaurant!
                      .restaurantCategories!.isNotEmpty
                  ? HeroiconsSolid.checkCircle
                  : HeroiconsOutline.puzzlePiece,
              title: "Menu",
              // icon2:  restaurantProfile!.time.isEmpty ? HeroiconsMini.checkBadge : null,
              color3: widget.restaurantProfile!.ownedRestaurant!
                      .restaurantCategories!.isNotEmpty
                  ? Tcolor.Secondary_S2
                  : Tcolor.TEXT_Label,
              onTap: () {
                Get.to(() => const OperatingHours(),
                    transition: Transition.leftToRightWithFade,
                    duration: const Duration(milliseconds: 700));
              },
            ),
          ),
          SizedBox(
            height: 31.h,
          ),
          CustomButton(
            title: "Request verification",
            textColor: Tcolor.TEXT_Label,
            btnColor: Tcolor.PRIMARY_T4,
            btnWidth: width,
            btnHeight: 75.h,
            raduis: 100.r,
            fontSize: 32.sp,
            onTap: () {
              setState(() {
                _isAwaitingVerification = true; // Update state on tap
              });
            },
            showArrow: false,
          ),
        ],
      ),
    );
  }
}
