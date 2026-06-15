// ignore_for_file: unnecessary_string_interpolations

import 'package:get_storage/get_storage.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/format_price.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/models/order_model.dart';
import 'package:vendor/views/orders/widget/widget/orderid_time.dart';
import 'package:vendor/views/orders/widget/widget/preparing_order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
    ),
    builder: (context) => Container(
      constraints: BoxConstraints(
        maxHeight: height,
      ),
      // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Container(
        child: content,
      ),
    ),
  );
}

class PreparingOrdersTile extends StatelessWidget {
  const PreparingOrdersTile({
    super.key,
    required this.order,
    this.refetch,
  });
  final OrderModel order;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      child: Container(
        padding:
            EdgeInsets.only(left: 30.w, right: 30.w, top: 15.w, bottom: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r), color: Tcolor.White),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderIdAndTime(
                  title1: "Order ID: ",
                  title2: order.orderSubId.toString(),
                  fontWeight: FontWeight.w700,
                ),
                GestureDetector(
                  onTap: () {
                    print("NExt");
                  },
                  child: Icon(
                    HeroiconsOutline.chevronRight,
                    size: 32.sp,
                    color: Tcolor.TEXT_Label,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            ReuseableText(
              title: "${order.orderItems[0].additives[0].foodTitle}",
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  color: Tcolor.Text),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, right: 10.h),
              child: Wrap(
                spacing: 10.w,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 5.h,
                children: [
                  Row(
                    children: [
                      ReuseableText(
                    title: "${order.orderItems[0].additives.length} items",
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w400,
                      color: Tcolor.TEXT_Label,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Tcolor.BORDER_Light,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("₦", style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w400,
                          color: Tcolor.TEXT_Label,
                        ),),
                      ReuseableText(
                        title: "${formatPrice(order.orderTotal)}",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                          color: Tcolor.TEXT_Label,
                        ),
                      ),
                    ],
                  ),
                    ],)
                  
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomButton(
              title: order.orderStatus == "Preparing"? "Order ready"  : order.orderStatus == "Ready" ? "Hand over to rider": "",
              showArrow: false,
              btnColor: Tcolor.PRIMARY_Button_color_2,
              btnWidth: width,
              btnHeight: 70.h,
              textColor: Tcolor.Text,
              fontSize: 28.sp,
              raduis: 100.r,
              onTap: () {
                print(box.read("fcm"));
                
              showCustomBottomSheet(
                context,
                PreparingOrdersDetails(order: order),
                1200.h, // Set the height for this bottom sheet
              );
              },
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
