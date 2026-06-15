import 'package:vendor/common/capitalize_text.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/controller/profile_detail_controller.dart';
import 'package:vendor/views/profile/widget/profile_details_widgets/delete_account.dart';
import 'package:vendor/views/profile/widget/profile_details_widgets/name_profile.dart';
import 'package:vendor/views/profile/widget/profile_details_widgets/password_profile.dart';
import 'package:vendor/views/profile/widget/profile_details_widgets/phone_profile.dart';
import 'package:vendor/views/profile/widget/profile_details_widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

void showCustomBottomSheet(
    BuildContext context, Widget content, double height) {
  showModalBottomSheet(
    backgroundColor: Tcolor.White,
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    builder: (context) => Container(
      constraints: BoxConstraints(
        maxHeight: height,
      ),
      // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: content,
      ),
    ),
  );
}

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final phone = box.read('phone');
    final email = box.read('email');
    final firstName = box.read('firstName');
    final lastName = box.read('lastName');

    final profileController = Get.put(ProfileDetailController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: const PageTitle(
                  title: "Profile details",
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: Column(
          children: [
            SizedBox(height: 70.h),
            GestureDetector(
              onTap: () {
                showCustomBottomSheet(
                  context,
                  const NameProfileBottomSheet(),
                  1200.h, // Set the height for this bottom sheet
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   ProfileTile(
                      title:
                          "${capitalizeFirstLetter(firstName)} ${capitalizeFirstLetter(lastName)}",
                      icon: HeroiconsOutline.user,
                      onTap: () {},
                    )
                  ,
                  Icon(
                    HeroiconsOutline.pencil,
                    size: 32.sp,
                    color: Tcolor.TEXT_Label,
                  )
                ],
              ),
            ),
            SizedBox(height: 70.h),
            GestureDetector(
              onTap: () {
                // Show bottom sheet for editing phone number
                showCustomBottomSheet(
                  context,
                  const PhoneProfileBottomsheet(),
                  1400.h, // Adjust the height as needed
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileTile(
                      title: phone,
                      icon: HeroiconsOutline.devicePhoneMobile,
                      onTap: () {},
                    ),
                  
                  Icon(
                    HeroiconsOutline.pencil,
                    size: 32.sp,
                    color: Tcolor.TEXT_Label,
                  )
                ],
              ),
            ),
            SizedBox(height: 70.h),
            GestureDetector(
              onTap: () {
                // Show bottom sheet for editing email
                // showCustomBottomSheet(
                //   context,
                //   EmailBottomSheet(),
                //   300.h, // Adjust the height as needed
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileTile(
                    title: email,
                    icon: HeroiconsOutline.envelope,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 70.h),
            GestureDetector(
              onTap: () {
                // Show bottom sheet for editing email
                showCustomBottomSheet(
                  context,
                  const PasswordProfileBottomSheet(),
                  1200.h, // Adjust the height as needed
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileTile(
                    title: "Update password",
                    icon: HeroiconsOutline.lockClosed,
                    onTap: () {},
                  ),
                  Icon(
                    HeroiconsOutline.pencil,
                    size: 32.sp,
                    color: Tcolor.TEXT_Label,
                  )
                ],
              ),
            ),
            SizedBox(height: 70.h),
            GestureDetector(
              onTap: () {
                Get.to(() => const DeleteAccount(),
                    transition: Transition.leftToRight,
                    duration: const Duration(milliseconds: 700));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileTile(
                    title: "Delete account",
                    icon: HeroiconsOutline.trash,
                    onTap: () {
                      Get.to(() => const DeleteAccount(),
                          transition: Transition.leftToRight,
                          duration: const Duration(milliseconds: 700));
                    },
                    color: Tcolor.ERROR_Reg,
                  ),
                  Icon(
                    HeroiconsOutline.chevronRight,
                    size: 32.sp,
                    color: Tcolor.TEXT_Label,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
