import 'package:lottie/lottie.dart';
import 'package:vendor/common/capitalize_text.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/format_price.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/order_controller.dart';
import 'package:vendor/models/order_model.dart';
import 'package:vendor/views/orders/widget/widget/orderid_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vendor/views/orders/widget/widget/pin_entry_dialog.dart';
import 'package:vendor/views/orders/widget/widget/track_rider_location.dart';

String formatDate(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr).toLocal();
  DateFormat outputFormat = DateFormat('EEE, d MMM yyyy, h:mm a', 'en_US');
  return outputFormat.format(dateTime);
}

String hourTime(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr).toLocal();
  DateFormat outputFormat = DateFormat('h:mm a', 'en_US');
  return outputFormat.format(dateTime);
}

class PreparingOrdersDetails extends StatelessWidget {
  const PreparingOrdersDetails({super.key, required this.order, this.refetch});

  final OrderModel order;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          decoration: BoxDecoration(
              color: Tcolor.White, borderRadius: BorderRadius.circular(20.r)),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Container(
                  color: Tcolor.White,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReuseableText(
                        title: "Order details",
                        style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                            color: Tcolor.Text),
                      ),
                      Container(
                        height: 64.h,
                        width: 64.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.h),
                            color: Tcolor.BACKGROUND_Regaular),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            HeroiconsOutline.xMark,
                            color: Tcolor.Text,
                            size: 32.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                Container(
                  color: Tcolor.White,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OrderIdAndTime(
                        title1: "Order ID: ",
                        title2: order.orderSubId.toString(),
                        fontWeight: FontWeight.w700,
                      ),
                      OrderIdAndTime(
                        fontWeight: FontWeight.w400,
                        title1: "Order time: ",
                        title2: hourTime(order.createdAt.toString()),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                ReuseableText(
                  title: "ORDER DETAILS",
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Tcolor.Text),
                ),
                for (int i = 0; i < order.orderItems[0].quantity; i++)
                  Container(
                    key: ValueKey(i),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReuseableText(
                              title: "Pack ${i + 1}",
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                                color: Tcolor.Text,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "₦",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25.sp,
                                      // height: 2.h,
                                      color: Tcolor.TEXT_Body),
                                ),
                                ReuseableText(
                                  title: "${formatPrice((order.orderTotal) / (order.orderItems[0].additives[0].packCount))}",
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Tcolor.TEXT_Body,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: order.orderItems.length,
                          itemBuilder: (context, index) {
                            final orderItem = order.orderItems[index];
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReuseableText(
                                      title: order
                                          .orderItems[0].additives[0].foodTitle,
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Tcolor.TEXT_Body,
                                      ),
                                    ),
                                    ReuseableText(
                                      title:
                                          "x${order.orderItems[0].additives[0].foodCount}",
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Tcolor.TEXT_Label,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.w),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: orderItem.additives.length,
                                  itemBuilder: (context, additiveIndex) {
                                    final additive =
                                        orderItem.additives[additiveIndex];
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ReuseableText(
                                            title: additive.name,
                                            style: TextStyle(
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Tcolor.TEXT_Body,
                                            ),
                                          ),
                                          ReuseableText(
                                            title: "x${additive.quantity}",
                                            style: TextStyle(
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Tcolor.TEXT_Label,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        Divider(
                            thickness: 2, color: Tcolor.BACKGROUND_Regaular),
                      ],
                    ),
                  ),
                if (order.riderAssigned) ...[
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: CustomButton(
                      title: "Track Rider",
                      showArrow: false,
                      btnHeight: 70.h,
                      btnWidth: 300.w,
                      btnColor: Tcolor.SECONDARY_Button,
                      raduis: 30.r,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      onTap: () {
                        print("order Id: ${order.id}");
                        Get.to(
                          () => const TrackRiderLocation(),
                          arguments: order.id, // Pass the order ID here
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h,),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReuseableText(
                      title: "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 32.sp,
                          color: Tcolor.TEXT_Body),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "₦",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 29.sp,
                              // height: 2.h,
                              color: Tcolor.Text),
                        ),
                        ReuseableText(
                          title: "${formatPrice(order.orderTotal)}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 32.sp,
                              color: Tcolor.Text),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(thickness: 2, color: Tcolor.BACKGROUND_Regaular),
                SizedBox(height: 10.h),
                ReuseableText(
                  title: "CUSTOMER’S INSTRUCTIONS",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                      color: Tcolor.TEXT_Label),
                ),
                SizedBox(height: 20.h),
                ReuseableText(
                  title: order.feedback,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 32.sp,
                      color: Tcolor.TEXT_Body),
                ),
                Divider(thickness: 2, color: Tcolor.BACKGROUND_Regaular),
                SizedBox(height: 10.h),
                ReuseableText(
                  title: "CUSTOMER’S DETAILS",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                      color: Tcolor.TEXT_Label),
                ),
                SizedBox(height: 20.h),
                ReuseableText(
                  title: capitalizeFirstLetter(order.customerName),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 32.sp,
                      color: Tcolor.TEXT_Body),
                ),
                SizedBox(height: 20.h),
                ReuseableText(
                  title: order.customerPhone,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                      color: Tcolor.TEXT_Label),
                ),
                Divider(thickness: 2, color: Tcolor.BACKGROUND_Regaular),
                SizedBox(height: 40.h),
                CustomButton(
                  title: order.orderStatus == "Preparing"
                      ? "Order ready"
                      : order.orderStatus == "Ready"
                          ? "Hand over to rider"
                          : "",
                  border: Border.all(color: Tcolor.BACKGROUND_Regaular),
                  showArrow: false,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  textColor: Tcolor.Text,
                  btnColor: Tcolor.PRIMARY_Button_color_2,
                  btnHeight: 80.h,
                  btnWidth: width,
                  raduis: 50.r,
                  onTap: () {
                    print("tap");
                    if (order.orderStatus == "Preparing") {
                      controller.acceptOrder(order.id, "Ready");
                    }
                    if (order.orderStatus == "Ready") {
                      Get.dialog(
                        PinEntryDialog(
                          onSubmit: (String pin) async {
                            bool success = await controller.verifyPickupPin(order.id, pin);
                            if(success) {
                              Get.back();
                            }
                          },
                          
                        ),
                        barrierDismissible: false
                      );
                    }
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
        Obx(() {
          if (controller.isLoading) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Dim background
                child: Center(
                  child: LottieBuilder.asset(
                    'assets/animation/loading_state.json', // Replace with your Lottie file path
                    width: 200.w,
                    height: 200.h,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}

// 1694
