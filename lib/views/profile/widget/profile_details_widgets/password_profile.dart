import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/pack_field.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/common/update_pasword_field.dart';
import 'package:vendor/controller/profile_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class PasswordProfileBottomSheet extends StatefulWidget {
  const PasswordProfileBottomSheet({super.key});

  @override
  State<PasswordProfileBottomSheet> createState() => _PasswordProfileBottomSheetState();
}

class _PasswordProfileBottomSheetState extends State<PasswordProfileBottomSheet> {
  late ProfileDetailController profileController;

   @override
  void initState() {
    super.initState();
    profileController = Get.put(ProfileDetailController());
  }

  @override
  void dispose() {
    Get.delete<ProfileDetailController>();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userId = box.read("userID");

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
                  title: "Update password",
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
                        profileController.newPasswordController.text = "";
                    profileController.oldPasswordController.text = "";
                    profileController.confirmPasswordController.text = "";
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
                      title: "Current password",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UpdatePasswordField(
                              height: 80.h,
                              controller: profileController.oldPasswordController,
                              fillColor: profileController.errorMessage.isNotEmpty
                                  ? Tcolor.ERROR_Light_2
                                  : Tcolor.BACKGROUND_Regaular,
                              borderColor: profileController.errorMessage.isNotEmpty
                                  ? Tcolor.ERROR_Reg
                                  : Tcolor.BACKGROUND_Regaular,
                              onChanged: (value) {
                                profileController.oldPassword.value = value;
                                profileController.validateForm();
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            if (profileController.errorMessage.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8.h,
                                    left:
                                        8.w), // Adjust left padding as needed
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ReuseableText(
                                        title: profileController.errorMessage.value,
                                        style: TextStyle(
                                          color: Tcolor.ERROR_Reg,
                                          fontSize: 24.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ReuseableText(
                      title: "New password",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PackField(
                      controller: profileController.newPasswordController,
                      height: 80.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ReuseableText(
                      title: "Confirm password",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UpdatePasswordField(
                              height: 80.h,
                              controller: profileController.confirmPasswordController,
                              fillColor: profileController.errorMessage1.isNotEmpty
                                  ? Tcolor.ERROR_Light_2
                                  : Tcolor.BACKGROUND_Regaular,
                              borderColor: profileController.errorMessage1.isNotEmpty
                                  ? Tcolor.ERROR_Reg
                                  : Tcolor.BACKGROUND_Regaular,
                              onChanged: (value) {
                                profileController.confirmPassword.value = value;
                                 profileController.compareNewPassword(
              profileController.newPasswordController.text,
              value, // Use the current value from the onChanged
          );
                                profileController.validateForm();
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            if (profileController.errorMessage1.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8.h,
                                    left:
                                        8.w), // Adjust left padding as needed
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ReuseableText(
                                        title: profileController.errorMessage1.value,
                                        style: TextStyle(
                                          color: Tcolor.ERROR_Reg,
                                          fontSize: 24.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
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
                if (profileController.newPasswordController.text ==
                    profileController.confirmPasswordController.text && profileController.errorMessage.value.isEmpty && profileController.errorMessage1.isEmpty && profileController.newPasswordController.text.isNotEmpty && profileController.oldPasswordController.text.isNotEmpty) {
                  int? statusCode = await profileController.changePassword(
                    userId,
                    profileController.newPasswordController.text,
                    profileController.oldPasswordController.text,
                  );

                  if (statusCode == 200) {
                    profileController.newPasswordController.text = "";
                    profileController.oldPasswordController.text = "";
                    profileController.confirmPasswordController.text = "";
                    Get.close(1);
                  }
                } else {
                      print("password not the same.");
                      
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
