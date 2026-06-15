import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/pack_field.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/profile_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class NameProfileBottomSheet extends StatelessWidget {
  const NameProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userId = box.read("userID");
    // final controller = Get.put(EditProfileName());
    final profileController = Get.put(ProfileDetailController());

    
    return Container(
      width: width,
      height: 1200.h,
      decoration: BoxDecoration(
        color: Tcolor.White,
         borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r))
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReuseableText(
                  title: "Edit name",
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
                      title: "First name",
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
                      
                      prefixIcon: Icon(
                        HeroiconsOutline.user,
                        size: 32.sp,
                      ),
                      hintText: "e.g john",
                      controller: profileController.firstNameController,
                      
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ReuseableText(
                      title: "Last name",
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
                      prefixIcon: Icon(
                        HeroiconsOutline.user,
                        size: 32.sp,
                      ),
                      hintText: "e.g john",
                      
                      controller: profileController.lastNameController,
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
                   int? statusCode = await profileController.changeName(userId, profileController.firstNameController.text, profileController.lastNameController.text);
                   

                   if( statusCode == 200){
                    profileController.firstNameController.text = "";
                   profileController.lastNameController.text = "";
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