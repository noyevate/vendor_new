import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class SupportMaintenance extends StatelessWidget {
  const SupportMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Adapts to screen width
      height: 1400.h,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header / Close Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(), // Pushes the button to the right
              Container(
                height: 70.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: Tcolor.BACKGROUND_Dark,
                  borderRadius: BorderRadius.circular(60.r),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      HeroiconsOutline.xMark,
                      color: Tcolor.Text,
                      size: 32.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content wrapped in Expanded so it never overflows
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  ReuseableText(
                    title: "Support & Maintenance",
                    style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: Tcolor.Text),
                  ),
                  SizedBox(height: 20.h),

                  // Using native Text here so it wraps naturally
                  Text(
                    "Running a business is fast-paced, and we are here to help. Here is how to get support and keep your app running smoothly:",
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w400,
                      color: Tcolor.TEXT_Body,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Step 1
                  _buildListItem("1.", "Contact Live Support",
                      "Got an urgent issue with an active order, a dispatch rider, or a payout? Use the 'Chat with Support' button in the app to speak with our team immediately."),

                  // Step 2
                  _buildListItem("2.", "Keep the App Updated",
                      "We regularly release updates to improve speed and add new features. Always ensure your Chopnow Vendor app is updated via the App Store or Play Store."),

                  // Step 3
                  _buildListItem("3.", "Reporting a Bug",
                      "If a feature isn't working correctly, take a screenshot and send it to our technical team through the 'Report an Issue' section so we can fix it."),

                  // Step 4
                  _buildListItem("4.", "Scheduled Maintenance",
                      "Occasionally, we upgrade our servers to serve you better. We will always send an in-app notification in advance so you can plan your restaurant operations."),

                  // Step 5
                  _buildListItem("5.", "Self-Service Help Center",
                      "For general questions about menu editing, operating hours, or resetting your password, browse our FAQs and Help Center for instant answers."),

                  SizedBox(height: 60.h), // Bottom padding
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Helper widget to keep the design consistent and prevent text overflow
  Widget _buildListItem(String number, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 35.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReuseableText(
            title: number,
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: Tcolor.PRIMARY_Button_color_2,
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bold Title
                ReuseableText(
                  title: title,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: Tcolor.Text,
                  ),
                ),
                SizedBox(height: 8.h),
                // Native Text for the description so it naturally drops to the next line
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w400,
                    color: Tcolor.TEXT_Body,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
