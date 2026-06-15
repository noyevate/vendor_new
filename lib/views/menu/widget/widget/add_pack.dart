import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/pack_field.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/pack_controller.dart';
import 'package:vendor/controller/restaurant_menu_controller.dart';
import 'package:vendor/models/pack_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class AddPack extends StatefulWidget {
  const AddPack({super.key, this.refetch});
  final Function()? refetch;

  @override
  State<AddPack> createState() => _AddPackState();
}

class _AddPackState extends State<AddPack> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantMenuController(), permanent: true);
    final packController = Get.put(PackController());
    final box = GetStorage();
    var restaurantId = box.read("restaurantId");

    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
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
                title: "Add pack",
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
                      controller.pack.text = "";
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
            height: 40.h,
          ),
          ReuseableText(
            title: "Pack name",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
                color: Tcolor.TEXT_Label),
          ),
          SizedBox(
            height: 10.w,
          ),
          PackField(
            controller: controller.pack,
            hintText: "e.g Big pack",
          ),
          SizedBox(
            height: 40.h,
          ),
          ReuseableText(
            title: "Pack description",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
                color: Tcolor.TEXT_Label),
          ),
          SizedBox(
            height: 10.w,
          ),
          PackField(
            controller: controller.packDescription,
            hintText: "e.g 100cl",
          ),
          SizedBox(
            height: 40.h,
          ),
          ReuseableText(
            title: "Pack price",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28.sp,
                color: Tcolor.TEXT_Label),
          ),
          SizedBox(
            height: 10.w,
          ),
          PackField(
            controller: controller.packPrice,
            keyboardType: TextInputType.number,
            hintText: "₦",
            prefix: Text(
              "₦ ",
              style: TextStyle(
                fontSize: 28.sp,
                color: Tcolor.Text,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              if (controller.pack.text.isNotEmpty &&
                  controller.packDescription.text.isNotEmpty &&
                  controller.packPrice.text.isNotEmpty) {
                int price = int.tryParse(controller.packPrice.text) ?? 0;
                final PackModel model = PackModel(
                    restaurantId: restaurantId,
                    packName: controller.pack.text,
                    packDescription: controller.packDescription.text,
                    price: price,
                    isAvailable: true);

                String data = packModelToJson(model);
                debugPrint(data);
                int? responseBody =
                    await packController.createPackFunctionAtAddMealPage(data);
                if (responseBody == 201) {
                  // Pass the response body to Navigator.pop
                  Get.back();

                  print(responseBody);
                } else {
                  // Handle error scenario if responseBody is null
                  Get.snackbar(
                    "Error",
                    "Failed to create additive",
                    colorText: Tcolor.Text,
                    backgroundColor: Tcolor.Secondary_Base,
                  );
                }
              }
            },
            child: CustomButton(
              title: "Add pack",
              fontSize: 28.sp,
              textColor: Tcolor.Text,
              fontWeight: FontWeight.w500,
              showArrow: false,
              btnHeight: 80.h,
              btnWidth: width,
              raduis: 100.r,
              btnColor:
                  Tcolor.PRIMARY_Button_color_2, // Solid color when not active,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
        ],
      ),
    );
  }
}
