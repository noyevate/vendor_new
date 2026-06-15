import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/format_price.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/order_controller.dart';
import 'package:vendor/models/order_model.dart';
import 'package:vendor/views/orders/widget/widget/accept_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
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

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.order, this.refetch,
  });
  final OrderModel order;
  final Function()? refetch;

  

  @override
  Widget build(BuildContext context) {
    
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
                ReuseableText(
                  title: "${order.orderItems[0].additives[0].foodTitle}",
                  style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w500,
                      color: Tcolor.Text),
                ),
                GestureDetector(
                  onTap: () {},
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
                        title: "${formatPrice(order.grandTotal)}",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:  CustomButton(
                      border: Border.all(color: Tcolor.BORDER_Regular),
                      title: "Reject",
                      showArrow: false,
                      btnColor: Tcolor.BACKGROUND_Regaular,
                      // btnWidth: 200.w,
                      btnHeight: 70.h,
                      textColor: Tcolor.Text,
                      fontSize: 28.sp,
                      raduis: 100.r,
                      onTap: () {
                        _showPopup(context);
                      },
                    ),
                  
                ),
                SizedBox(width: 20.w,),
                Expanded(
                  child: CustomButton(
                      title: "Accept",
                      showArrow: false,
                      // btnWidth: 200.w,
                      btnColor: Tcolor.PRIMARY_Button_color_2,
                      btnHeight: 70.h,
                      textColor: Tcolor.Text,
                      fontSize: 28.sp,
                      raduis: 100.r,
                      onTap: () {
                        showCustomBottomSheet(
                            context,
                            AcceptOrder(order: order),
                            1200.h, // Set the height for this bottom sheet
                          );
                      },
                      
                    ),
                  
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
  
void _showPopup(BuildContext context) {
  final controller = Get.put(OrderController());
  showDialog(
      context: context,
      barrierColor: const Color.fromRGBO(18, 20, 25, 0.8), // Dark overlay color
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 530.w,
            height: 220.h,
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, bottom: 10.h, top: 30.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReuseableText(
                  title: "Reject order",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28.sp,
                      color: Tcolor.Text),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ReuseableText(
                  title: "Are you sure you want to reject this order?",
                  style: TextStyle(
                      color: Tcolor.TEXT_Label,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the Row content
                  children: [
                    CustomButton(
                      title: "No, Cancel",
                      showArrow: false,
                      btnColor: Tcolor.White,
                      btnWidth: 220.w,
                      btnHeight: 72.h,
                      textColor: Tcolor.TEXT_Body,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w400,
                      onTap: () async {
                        Get.back();
                      },
                    ),
                    SizedBox(width: 10.w), // Space between buttons and divider
                    Container(
                      height: 50.h,
                      width: 5.w,
                      color: Tcolor.BACKGROUND_Dark,
                    ),
                    SizedBox(width: 10.w), // Space between divider and button
                    CustomButton(
                      title: "Yes, Reject", // Changed title for differentiation
                      showArrow: false,
                      btnColor: Tcolor.White,
                      btnWidth: 220.w,
                      btnHeight: 72.h,
                      textColor: Tcolor.ERROR_Reg,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w400,
                      
                      onTap: () async {
                       controller.rejectOrder(order.id, "Cancelled", refetch!);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

}
