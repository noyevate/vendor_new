import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/profile_detail_controller.dart';
import 'package:vendor/views/auth/widget/field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class PhoneProfileBottomsheet extends StatelessWidget {
  const PhoneProfileBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userId = box.read("userID");
    final profileController = Get.put(ProfileDetailController());

    return Container(
      width: width,
      height: 1200.h,
      decoration: BoxDecoration(
          color: Tcolor.White,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r))),
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReuseableText(
                  title: "Update phone number",
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReuseableText(
                      title: "Phone number",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150.w,
                          height: 115.h,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Tcolor.BACKGROUND_Regaular),
                            borderRadius: BorderRadius.circular(20.r),
                            color: Tcolor.BACKGROUND_Regaular,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/img/flag-for-flag-nigeria-svgrepo-com.svg",
                                  height: 40.h,
                                  width: 40.w,
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: Text(
                                    "+234",
                                    style: TextStyle(
                                      color: Tcolor.TEXT_Label,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 30.w),
                        Expanded(
                          child: FieldWidget(
                            prefixIcon: const Icon(Icons.phone),
                            hintText: "81 343 XXXX",
                            hintColor: Tcolor.TEXT_Placeholder,
                            hintFontSize: 30.sp,
                            hintFontWeight: FontWeight.w600,
                            cursorHeight: 30.sp,
                            cursorColor: Tcolor.Primary,
                            controller: profileController.phoneNumberController,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () async {
                int? stausCode = await profileController.changePhone(
                  userId,
                  profileController.phoneNumberController.text,
                );
                if (stausCode == 200) {
                  profileController.phoneNumberController.text = "";

                  Get.close(1);
                }
              },
              child: CustomButton(
                title: "Save Changes",
                showArrow: false,
                btnColor: Tcolor.PRIMARY_Button_color_2,
                fontSize: 28.sp,
                textColor: Tcolor.Text,
                raduis: 100.r,
                btnWidth: width / 1,
                btnHeight: 96.sp,
                
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
