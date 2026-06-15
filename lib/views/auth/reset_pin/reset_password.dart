import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/login_controller.dart';
import 'package:vendor/controller/reset_controller.dart';
import 'package:vendor/views/auth/login/widget/email_textfield.dart';
import 'package:vendor/views/auth/reset_pin/widget/reset_otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late final TextEditingController _emailController = TextEditingController();
      

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Column(
              children: [
                SizedBox(
                  height: 60.h,
                ),
                const PageTitle(),
              ],
            ),
          )),
      body: Container(
        height: height,
        width: width,
        color: Tcolor.White,
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    ReuseableText(
                      title: "Reset Password",
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        wordSpacing: 2.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ReuseableText(
                      title: "Enter your email address and a verification code will be sent to ",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: 10.h),
                    ReuseableText(
                      title: "reset your password",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 90.h),
                    ReuseableText(
                      title: "Email address",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 96.h,
                      child: EmailTextField(
                          hintText: "e.g Adewalejohn2example.com",
                          prefixIcon: Icon(
                            HeroiconsOutline.envelope,
                            size: 28.sp,
                          ),
                          controller: _emailController),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (_emailController.text.isNotEmpty ) {
                  print(" Object Tapped ...");
                  controller.resetPasswordOtp(_emailController.text);
                
                } else {
                  Get.snackbar(
                    'ensure you fill the fields...',
                    '',
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // Smaller margin
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5), // Compact padding
                    borderRadius: 8, // Rounded corners for a sleeker look
                    // backgroundColor: Colors.black
                    // .withOpacity(0.7), // Transparent background
                    colorText: Tcolor.PRIMARY_S4,
                    barBlur: 10, // Adds a blur effect
                    duration:
                        const Duration(seconds: 20), // Reduce display time
                  );
                }
              },
              child: CustomButton(
                title: "Send code",
                textColor: _emailController.text.isNotEmpty
                    ? Tcolor.Text
                    : Tcolor.TEXT_Label,
                btnColor: _emailController.text.isNotEmpty
                    ? Tcolor.PRIMARY_Button_color_2
                    : Tcolor.PRIMARY_T4,
                btnWidth: MediaQuery.of(context).size.width / 1.1,
                btnHeight: 96.h,
                raduis: 100.r,
                fontSize: 32.sp,
                showArrow: false,
              ),
            ),
            SizedBox(
              height: 50.h,
            )
          ],
        ),
      ),
    );
  }
}
