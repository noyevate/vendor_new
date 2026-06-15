import 'package:vendor/common/circle.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/views/profile/widget/profile_details_widgets/subWidget/delete_account_bottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import '../../../../common/reusable_text_widget.dart';

void showCustomBottomSheet(
    BuildContext context, Widget content, double height) {
  showModalBottomSheet(
    backgroundColor: Tcolor.White,
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    builder: (context) => Container(
      constraints: BoxConstraints(
        maxHeight: height,
      ),
      // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: content,
      ),
    ),
  );
}

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(DeleteAccountController());
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: const PageTitle(
                  title: "Delete account",
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  height: 520.h,
                  width: width,
                  decoration: BoxDecoration(
                      color: Tcolor.ERROR_Light_2,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: Tcolor.ERROR_Reg)),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 30.w, right: 30.w, top: 40.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 72.h,
                          width: 72.h,
                          decoration: BoxDecoration(
                              color: Tcolor.ERROR_Light_1,
                              borderRadius: BorderRadius.circular(100.r)),
                          child: Icon(
                            HeroiconsMini.trash,
                            size: 48.sp,
                            color: Tcolor.ERROR_Reg,
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        ReuseableText(
                          title: "Account Deletion Warning",
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: Tcolor.Text,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ReuseableText(
                          title: "You're about to permanently delete your ",
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: Tcolor.TEXT_Body,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        ReuseableText(
                          title: "ChopNow account! This action will: ",
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: Tcolor.TEXT_Body,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomCirclePin(
                                    height: 10.h,
                                    width: 10.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Column(
                                      children: [
                                        ReuseableText(
                                          title:
                                              "Remove all your data, preferences, and ",
                                          style: TextStyle(
                                              fontSize: 28.sp,
                                              color: Tcolor.TEXT_Body,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 30.w),
                                child: ReuseableText(
                                  title: "account information",
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Tcolor.TEXT_Body,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomCirclePin(
                                    height: 10.h,
                                    width: 10.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Column(
                                      children: [
                                        ReuseableText(
                                          title:
                                              "Require you to create a new account to use ",
                                          style: TextStyle(
                                              fontSize: 28.sp,
                                              color: Tcolor.TEXT_Body,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 30.w),
                                child: ReuseableText(
                                  title: "our services again",
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Tcolor.TEXT_Body,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                ReuseableText(
                  title: "Recovery Period:",
                  style: TextStyle(
                      fontSize: 32.sp,
                      color: Tcolor.Text,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomCirclePin(
                            height: 10.h,
                            width: 10.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Column(
                              children: [
                                ReuseableText(
                                  title:
                                      "You'll have a 30-day grace period to recover your",
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Tcolor.TEXT_Body,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.w),
                        child: ReuseableText(
                          title: "account",
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: Tcolor.TEXT_Body,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomCirclePin(
                            height: 10.h,
                            width: 10.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Column(
                              children: [
                                ReuseableText(
                                  title:
                                      "You'll have a 30-day grace period to recover your",
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Tcolor.TEXT_Body,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.w),
                        child: ReuseableText(
                          title: "account",
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: Tcolor.TEXT_Body,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ReuseableText(
                  title: "Proceed with caution!",
                  style: TextStyle(
                      fontSize: 28.sp,
                      color: Tcolor.Text,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 100.h,
                ),
                InkWell(
                  // splashColor: Tcolor.Primary,
                  // splashFactory: InkRipple.splashFactory,
                  onTap: () {
                    showCustomBottomSheet(
                      context,
                      const DeleteAccountBottomSheet(),
                      916.h, // Set the height for this bottom sheet
                    );
                  },
                  child: CustomButton(
                    onTap: () {},
                    title: 'Delete account',
                    showArrow: false,
                    fontSize: 28.sp,
                    btnWidth: width,
                    raduis: 100.r,
                    btnHeight: 92.sp,
                    textColor: Tcolor.White,
                    btnColor: Tcolor.ERROR_Reg,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                CustomButton(
                  title: 'Cancel',
                  showArrow: false,
                  fontSize: 28.sp,
                  btnWidth: width,
                  raduis: 100.r,
                  btnHeight: 92.sp,
                  textColor: Tcolor.PRIMARY_S4,
                  btnColor: Tcolor.White,
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
        ));
  }
}
