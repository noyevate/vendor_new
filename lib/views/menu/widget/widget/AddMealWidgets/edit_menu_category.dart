import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/restaurant_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class EditMenuCategory extends StatelessWidget {
  const EditMenuCategory(
      {super.key, required this.currentCategory, this.refetch});
  final String currentCategory;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantMenuController(), permanent: true);

    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        color: Tcolor.White,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableText(
                title: "Add menu category",
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
                      controller.menuCategory.text = "";
                      Get.back();
                    },
                    icon: Icon(
                      HeroiconsOutline.xMark,
                      color: Tcolor.Text,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          ReuseableText(
            title: "Category name",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
                color: Tcolor.TEXT_Label),
          ),
          SizedBox(
            height: 10.w,
          ),
          Container(
            height: 95.h,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Tcolor.BACKGROUND_Regaular),
              color: Tcolor.BACKGROUND_Regaular,
            ),
            child: TextField(
              controller: controller.menuCategory,
              //
              style: TextStyle(
                fontSize: 30.sp,
                color: Tcolor.TEXT_Body,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: 'e.g Protein',
                fillColor: Tcolor.BACKGROUND_Regaular,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 15.r,
                ),
                hintStyle: TextStyle(
                  color: Tcolor.TEXT_Placeholder,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableText(
                title: "Publish",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32.sp,
                  color: Tcolor.Text,
                ),
              ),
              Obx(() => Transform.scale(
                    scale: 0.6,
                    child: Switch.adaptive(
                      value: controller.isSwitched.value,
                      onChanged: controller.toggleSwitch,
                      activeColor:
                          const Color.fromRGBO(251, 178, 23, 1), // Active color
                      thumbColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.white; // White thumb when active
                        }
                        return Tcolor
                            .BACKGROUND_Regaular; // Regular thumb when inactive
                      }),
                      inactiveThumbColor:
                          Tcolor.BACKGROUND_Dark, // Inactive color
                    ),
                  )),
            ],
          ),
          const Spacer(),
          Obx(() => GestureDetector(
                onTap: controller.isButtonActive.value
                    ? () {
                        final String newCategory = controller.menuCategory.text;
                        controller.updateRestaurantCategoryName(
                            "668552324409ef9c2bb165eb",
                            currentCategory,
                            newCategory,
                            refetch!);
                        controller.menuCategory.text = "";
                        controller.isButtonActive.value = false;

                        Get.back();
                      }
                    : null,
                child: CustomButton(
                  title: "Add category",
                  fontSize: 28.sp,
                  textColor: controller.isButtonActive.value
                      ? Tcolor.Text
                      : Tcolor.TEXT_Label,
                  fontWeight: FontWeight.w500,
                  showArrow: false,
                  btnHeight: 80.h,
                  btnWidth: width,
                  raduis: 100.r,

                  btnColor: controller.isButtonActive.value
                      ? Tcolor
                          .PRIMARY_Button_color_2 // Gradient takes precedence
                      : Tcolor
                          .BACKGROUND_Regaular, // Solid color when not active,
                ),
              )),
          SizedBox(
            height: 60.h,
          ),
        ],
      ),
    );
  }
}
