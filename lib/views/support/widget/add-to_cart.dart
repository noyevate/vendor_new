import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class ManagingOrders extends StatelessWidget {
  const ManagingOrders({super.key});

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
                    title: "How to Manage Orders",
                    style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: Tcolor.Text),
                  ),
                  SizedBox(height: 20.h),

                  // Using native Text here so it wraps naturally
                  Text(
                    "Managing your orders quickly keeps your customers happy and your ratings high. Here is how to process an order:",
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w400,
                      color: Tcolor.TEXT_Body,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Step 1
                  _buildListItem("1.", "Receive Order Alert",
                      "When a customer places an order, you will receive a notification. The order will appear in your 'New' or 'Pending' orders tab."),

                  // Step 2
                  _buildListItem("2.", "Accept or Reject",
                      "Review the requested items. Tap 'Accept' to confirm the order and begin preparing the food, or 'Reject' if the item is out of stock."),

                  // Step 3
                  _buildListItem("3.", "Prepare the Meal",
                      "Prepare the order within the estimated timeframe. Make sure the food is packaged securely to prevent spilling during transit."),

                  // Step 4
                  _buildListItem("4.", "Mark as Ready",
                      "Once the food is packed and ready to go, update the order status to 'Ready for Delivery'. This notifies the assigned dispatch rider."),

                  // Step 5
                  _buildListItem("5.", "Handover to Rider",
                      "When the Chopnow rider arrives, verify the order details and hand over the packaged meal to complete the process."),

                  SizedBox(height: 60.h), // Bottom padding
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Helper widget to keep your code clean and prevent text overflow
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
