import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: const PageTitle(
              title: "Privacy Policy",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            ReuseableText(
              title: '1. Introduction',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text),
            ),
            SizedBox(height: 10.h),
            ReuseableText(
              title: 'Welcome to ChopNow. Your privacy is our priority.',
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Tcolor.Text,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20.h),
            ReuseableText(
              title: '2. Information We Collect',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text),
            ),
            SizedBox(height: 10.h),
            ReuseableText(
              title: '- Personal Information (Name, Email, Phone Number)\n'
                  '- Payment Information\n'
                  '- Location Data\n'
                  '- Device Information',
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Tcolor.Text,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20.h),
            ReuseableText(
              title: '3. How We Use Your Information',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text),
            ),
            SizedBox(height: 10.h),
            ReuseableText(
              title: '- To process orders and payments\n'
                  '- To improve our services\n'
                  '- To communicate with you about orders or updates\n'
                  '- For security and fraud prevention',
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Tcolor.Text,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20.h),
            ReuseableText(
              title: '4. Sharing Your Information',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text),
            ),
            SizedBox(height: 10.h),
            ReuseableText(
              title:
                  'We do not sell or trade your personal data. We may share\n information with partners involved in fulfilling your orders\n such as restaurants and delivery services.',
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Tcolor.Text,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20.h),
            ReuseableText(
              title: '5. Security',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text),
            ),
            SizedBox(height: 10.h),
            ReuseableText(
              title:
                  'We implement appropriate measures to protect your data.\n However, no system is completely secure. Please guard\n your account information.',
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Tcolor.Text,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20.h),
            ReuseableText(
              title: '6. Changes to this Policy',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text),
            ),
            SizedBox(height: 10.h),
            ReuseableText(
              title:
                  'We may update this policy periodically. You will be notified\n of significant changes through the app or email.',
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Tcolor.Text,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20.h),
            ReuseableText(
              title: '7. Contact Us',
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text),
            ),
            SizedBox(height: 10.h),
            ReuseableText(
              title:
                  'If you have any questions about this Privacy Policy, please\n contact us at support@chopnow.com.',
              style: TextStyle(
                  fontSize: 28.sp,
                  color: Tcolor.Text,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
