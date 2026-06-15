import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/enty_point.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h), child: Container()),
      body: Container(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300.h,
                width: 350.w,
                child: Image.asset("assets/img/checkers.png"),
              ),
              SizedBox(
                height: 50.h,
              ),
              ReuseableText(
                title: "Set up your",
                style: TextStyle(
                  color: Tcolor.Text,
                  fontSize: 80.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              ReuseableText(
                title: "restaurant",
                style: TextStyle(
                  color: Tcolor.Text,
                  fontSize: 80.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              ReuseableText(
                title: "To get started, please take a few minutes to set up  ",
                style: TextStyle(
                    color: Tcolor.TEXT_Body,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.5.sp),
              ),
              ReuseableText(
                title: "your restaurant profile.",
                style: TextStyle(
                    color: Tcolor.TEXT_Body,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.5.sp),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: 320.h,
                width: width,
                padding: EdgeInsets.only(left: 50.w, right: 50.w),
                decoration: BoxDecoration(
                    color: Tcolor.SECONDARY_T2,
                    borderRadius: BorderRadius.circular(25.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return Tcolor.SECONDARY_Button_gradient
                                .createShader(bounds);
                          },
                          child: Icon(
                            HeroiconsMini.checkBadge,
                            size: 40.sp,
                            color: Colors
                                .white, // This color is irrelevant because the gradient shader will replace it
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        ReuseableText(
                          title: "Restaurant Profile",
                          style: TextStyle(
                              color: Tcolor.TEXT_Body,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.5.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 55.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReuseableText(
                            title: "Setup your restaurant profile, operational",
                            style: TextStyle(
                                color: Tcolor.TEXT_Label,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 2.5.sp),
                          ),
                          ReuseableText(
                            title: "hours, and payout details.",
                            style: TextStyle(
                                color: Tcolor.TEXT_Label,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 2.5.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return Tcolor.SECONDARY_Button_gradient
                                .createShader(bounds);
                          },
                          child: Icon(
                            HeroiconsMini.checkBadge,
                            size: 40.sp,
                            color: Colors
                                .white, // This color is irrelevant because the gradient shader will replace it
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        ReuseableText(
                          title: "Restaurant menu",
                          style: TextStyle(
                              color: Tcolor.TEXT_Body,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.5.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 55.w),
                      child: ReuseableText(
                        title: "Add your menu items.",
                        style: TextStyle(
                            color: Tcolor.TEXT_Label,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2.5.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              CustomButton(
                title: "Set up restaurant",
                showArrow: false,
                btnHeight: 90.h,
                raduis: 100.r,
                textColor: Tcolor.Text,
                fontSize: 32.sp,
                
                btnColor: Tcolor.PRIMARY_Button_color_2,
                onTap: () {
                  Get.to(() => const RestaurantProfile(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 700));
                },
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                title: "Do this later",
                showArrow: false,
                btnColor: Tcolor.White,
                btnHeight: 90.h,
                raduis: 100.r,
                textColor: Tcolor.PRIMARY_S4,
                fontSize: 32.sp,
                arrowColor: Tcolor.Text,
                onTap: () {
                  Get.to(() => const MainScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
