import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: const PageTitle(
              title: "Terms of Use",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              '1. Introduction',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 16.h),
            Text(
              'Welcome to ChopNow. By using our app, you agree to comply with and be bound by the following terms and conditions. Please read these terms carefully.',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 20.h),
            Text(
              '2. User Obligations',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 16.h),
            Text(
              'As a user of ChopNow, you agree to use the app responsibly and comply with all applicable laws and regulations. You are responsible for maintaining the confidentiality of your account and password.',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 20.h),
            Text(
              '3. Prohibited Activities',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 16.h),
            Text(
              'You may not use the app for any unlawful or unauthorized purposes, including but not limited to fraud, harassment, or spamming other users.',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 16.h.h),
            Text(
              '4. Intellectual Property',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 16.h),
            Text(
              'All content, trademarks, and data on this app, including but not limited to text, images, logos, and software, are the property of ChopNow or its licensors and are protected by copyright laws.',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 20.h),
            Text(
              '5. Limitation of Liability',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 16.h),
            Text(
              'ChopNow will not be liable for any direct, indirect, incidental, or consequential damages resulting from your use of the app.',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 20.h),
            Text(
              '6. Termination',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 16.h),
            Text(
              'We reserve the right to terminate or suspend your access to the app at any time, without prior notice, for conduct that we believe violates these terms.',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 20.h),
            Text(
              '7. Changes to Terms',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 16.h),
            Text(
              'ChopNow reserves the right to modify these terms at any time. Your continued use of the app constitutes your acceptance of the updated terms.',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 20.h),
            Text(
              '8. Contact Us',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 16.h),
            Text(
              'If you have any questions or concerns about these terms, please contact us at support@chopnow.com.',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Tcolor.Text,
                  fontFamily: 'Aeonik'),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
