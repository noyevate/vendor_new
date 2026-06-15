import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class VendorGetStarted extends StatelessWidget {
  const VendorGetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1400.h,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  ReuseableText(
                    title: "Getting Started",
                    style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: Tcolor.Text),
                  ),
                  SizedBox(height: 20.h),
                  ReuseableText(
                    title:
                        "Welcome to Chopnow! Follow these easy steps to set up your restaurant and start earning:",
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w400,
                      color: Tcolor.TEXT_Body,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  _buildListItem("1.", "Set up your Profile",
                      "Complete your restaurant details, set your daily operating hours, and add your bank account for payouts."),

                  _buildListItem("2.", "Upload your Menu",
                      "Add your food categories, upload clear images of your meals, and set your prices."),

                  _buildListItem("3.", "Accept Orders",
                      "When a customer orders, you will receive a notification. Accept the order and start preparing the food immediately."),

                  _buildListItem("4.", "Hand over for Delivery",
                      "Once the meal is ready and packaged securely, hand it over to our dispatch rider for delivery to the customer."),

                  _buildListItem("5.", "Track Earnings & Get Paid",
                      "Monitor your sales history from your dashboard. Your earnings will be sent automatically to your payout account."),

                  SizedBox(height: 60.h), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                // Bold Title for the step
                ReuseableText(
                  title: title,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: Tcolor.Text,
                  ),
                ),
                SizedBox(height: 8.h),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w400,
                    color: Tcolor.TEXT_Body,
                  ),
                  softWrap:
                      true, // This guarantees the text wraps to the next line
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
