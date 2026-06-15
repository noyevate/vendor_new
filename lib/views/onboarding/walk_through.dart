import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/views/auth/create_account/create_account_page.dart';
import 'package:vendor/views/auth/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/controller/login_controller.dart';


class WalkThrough extends StatelessWidget {
  const WalkThrough({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Container(
      height: height,
      width: width,
      color: Tcolor.White,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                        height: 60.h,
                      ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Image.asset(
                  "assets/img/Image_1.png",
                  height: 700.h,
                  width: width,
                ),
              ),
              
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 20.h,
                      ),
                      ReuseableText(
                        title: "Welcome to",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 80.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      ReuseableText(
                        title: "ChopNow!",
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
                        title:
                            "Start growing your restaurant business with our ",
                        style: TextStyle(
                          color: Tcolor.TEXT_Body,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ReuseableText(
                        title:
                            "innovative ordering and delivery solutions, designed",
                        style: TextStyle(
                          color: Tcolor.TEXT_Body,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ReuseableText(
                        title:
                            "to help you reach new customers and increase sales.",
                        style: TextStyle(
                          color: Tcolor.TEXT_Body,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      CustomButton(
                        title: "Create account",
                        showArrow: false,
                        btnHeight: 90.h,
                        raduis: 100.r,
                        textColor: Tcolor.Text,
                        fontSize: 32.sp,
                        btnColor: Tcolor.PRIMARY_Button_color_2,
                        onTap: () {
                          
                          Get.to(() => const CreateAccount(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 700));
                        
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomButton(
                        title: "Login",
                        showArrow: true,
                        btnColor: Tcolor.White,
                        btnHeight: 90.h,
                        raduis: 100.r,
                        textColor: Tcolor.Text,
                        fontSize: 32.sp,
                        arrowColor: Tcolor.Text,
                        border: Border.all(color: Tcolor.BORDER_Regular),
                        onTap: () {
                          controller.setLoading = false;
                          Get.to(() => const LoginPage());
                        },
                      ),
                      
                  ],
                ),
              )
              
              
              
            ],
          ),
        ),
      ),
    );
  }
}
