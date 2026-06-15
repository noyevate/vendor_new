import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/common/update_pasword_field.dart';
import 'package:vendor/controller/profile_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileDetailController());
    return Container(
        width: width,
        height: 916.h,
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
        decoration: BoxDecoration(
            color: Tcolor.White,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReuseableText(
                  title: "Delete Account",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 32.sp,
                      color: Tcolor.Text),
                ),
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
                        controller.passwordController.text = "";
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
            SizedBox(
              height: 80.h,
            ),
            ReuseableText(
              title: "To confirm account deletion, enter your password",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 28.sp,
                  color: Tcolor.Text),
            ),
            SizedBox(
              height: 40.h,
            ),
            
            ReuseableText(
              title: "Password",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 28.sp,
                  color: Tcolor.TEXT_Label),
            ),
            SizedBox(
              height: 20.h,
            ),
            UpdatePasswordField(
              borderColor: Tcolor.BACKGROUND_Regaular,
              controller: controller.passwordController ,
            ),
            const Spacer(),

            CustomButton(
                onTap: (){
                  
                },
                title: 'Delete account',
                showArrow: false,
                fontSize: 28.sp,
                btnWidth: width,
                raduis: 100.r,
                btnHeight: 92.sp,
                textColor: Tcolor.White,
                btnColor: Tcolor.ERROR_Reg,
                
              ),
              SizedBox(
              height: 40.h,
            ),

          ],
        ));
  }
}
