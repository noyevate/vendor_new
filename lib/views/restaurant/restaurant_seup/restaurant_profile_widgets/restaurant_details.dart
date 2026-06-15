import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/setup_field.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/restaurant_setup_controller.dart';
import 'package:vendor/controller/uploader_controller.dart';
import 'package:vendor/enty_point.dart';
import 'package:vendor/models/create_restaurant_model.dart';
import 'package:vendor/views/restaurant/widget/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantSetupController());
    final uploadController = Get.put(UploaderController());
    var latitude;
    var longitude;
    var postalCode;
    final box = GetStorage();
    var userId = box.read("userID");

    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Column(
                  children: [
                    const PageTitle(
                      title: "Restaurant Details",
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              color: Tcolor.White,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    ReuseableText(
                      title: "Restaurant logo",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        uploadController.pickImage("logo");
                      },
                      child: Stack(
                        children: [
                          Obx(
                            () => Container(
                              width: 170.w,
                              height: 170.h,
                              decoration: BoxDecoration(
                                color: Tcolor.BORDERImageUpload,
                                border: Border.all(
                                    color:
                                        Tcolor.BORDERImageUploadCircumference),
                                shape: BoxShape.circle,
                              ),
                              child: uploadController.logoUrl == ''
                                  ? Center(
                                      child: Icon(
                                        HeroiconsOutline.user,
                                        color: Tcolor.BorderUserIcon,
                                        size: 40.sp,
                                      ),
                                    )
                                  : ClipOval(
                                      child: Image.network(
                                        uploadController.logoUrl,
                                        width: 170.w,
                                        height: 170.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 52.w,
                              height: 52.h,
                              decoration: BoxDecoration(
                                  color: Tcolor.UploadIcon,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Tcolor.BorderUploadIcon)),
                              child: Icon(
                                HeroiconsOutline.camera,
                                color: Tcolor.TEXT_White,
                                size: 32.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    ReuseableText(
                      title: "Restaurant name",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SetupField(
                      prefixIcon: Icon(
                        HeroiconsOutline.buildingStorefront,
                        size: 28.sp,
                        color: Tcolor.TEXT_Label,
                      ),
                      controller: controller.restaurantName,
                      hintText: "e.g Item 7",
                      onChanged: (value) => controller.validateForm(),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ReuseableText(
                      title: "Restaurant address",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SetupField(
                      prefixIcon: Icon(
                        HeroiconsOutline.mapPin,
                        size: 28.sp,
                        color: Tcolor.TEXT_Label,
                      ),
                      controller: controller.restaurantAddress,
                      hintText: "e.g Phase 1 Road, Ilorin 240281, Kwara",
                      onChanged: (value) => controller.validateForm(),
                      onTap: () async {
                        // Navigate to the address search page and wait for the result
                        var result =
                            await Get.to(() => const AddressSearchPage());

                        // If an address was selected, update the text field and store details
                        if (result != null) {
                          controller.restaurantAddress.text = result['address'];
                          postalCode = result['postalCode'];
                          latitude = result['latitude'];
                          longitude = result['longitude'];
                        }
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ReuseableText(
                      title: "Official email address",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SetupField(
                      prefixIcon: Icon(
                        HeroiconsOutline.envelope,
                        size: 28.sp,
                        color: Tcolor.TEXT_Label,
                      ),
                      controller: controller.restaurantEmail,
                      hintText: "e.g restaurant@example.com",
                      onChanged: (value) => controller.validateForm(),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ReuseableText(
                      title: "Official phone number",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SetupField(
                      prefixIcon: Icon(
                        HeroiconsOutline.devicePhoneMobile,
                        size: 28.sp,
                        color: Tcolor.TEXT_Label,
                      ),
                      controller: controller.restaurantphone,
                      hintText: "e.g 08164xxxxxx",
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => controller.validateForm(),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        uploadController.pickImage("cover");
                      },
                      child: Obx(
                        () => Container(
                          height: 270.h,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r)),
                              color: Tcolor.BACKGROUND_Regaular),
                          child: uploadController.coverUrl == ''
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                    Container(
                                      height: 100.h,
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Tcolor.BACKGROUND_Dark),
                                      child: Icon(
                                        HeroiconsOutline.camera,
                                        color: Tcolor.Text,
                                        size: 40.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    ReuseableText(
                                      title: "Upload cover image",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Body,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    ReuseableText(
                                      title:
                                          "JPG & PNG format of max size of 2MB",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Label,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.r),
                                      topRight: Radius.circular(30.r)),
                                  child: Image.network(
                                    uploadController.coverUrl,
                                    width: 170.w,
                                    height: 170.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Container(
                      height: 90.h,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.r),
                              bottomRight: Radius.circular(30.r)),
                          color: Tcolor.SECONDARY_T2),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return Tcolor.SECONDARY_Button_gradient
                                        .createShader(bounds);
                                  },
                                  child: Icon(
                                    HeroiconsMini.informationCircle,
                                    size: 40.sp,
                                    color: Colors
                                        .white, // This color is irrelevant because the gradient shader will replace it
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                ReuseableText(
                                  title:
                                      "Eye-catching image of your top menu item to",
                                  style: TextStyle(
                                    color: Tcolor.TEXT_Body,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 60.w),
                              child: ReuseableText(
                                title: "entice ustomers.",
                                style: TextStyle(
                                  color: Tcolor.TEXT_Body,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Obx(
                      () => CustomButton(
                        title: "Save changes",
                        textColor: controller.isFormFilled.value
                            ? Tcolor.Text
                            : Tcolor.TEXT_Label,
                        btnColor: controller.isFormFilled.value &&
                                uploadController.logoUrl != "" &&
                                uploadController.coverUrl != ""
                            ? Tcolor.PRIMARY_Button_color_2
                            : Tcolor.PRIMARY_T4,
                        btnWidth: width,
                        btnHeight: 96.h,
                        raduis: 100.r,
                        fontSize: 32.sp,
                        showArrow: false,
                        onTap: controller.isFormFilled.value &&
                                uploadController.logoUrl != "" &&
                                uploadController.coverUrl != ""
                            ? () async {
                                print("postalCode: $postalCode");
                                print("lat: $latitude");
                                print("lng: $longitude");
                                debugPrint("userId: ${userId}");

                                final restaurantName =
                                    controller.restaurantName.text;
                                final restaurantEmail =
                                    controller.restaurantEmail.text;
                                final restaurantPhone =
                                    controller.restaurantphone.text;
                                final restaurantAddress =
                                    controller.restaurantAddress.text;
                                // FirebaseMessaging messaging =
                                //     FirebaseMessaging.instance;
                                // String? fcm = await messaging.getToken() ??
                                //     "dfjkdskfksdnjkndfjkndskjnf;dsknvkdjnfvjkfvjb";
                                // debugPrint("fcm: ${fcm}");

                                FirebaseMessaging messaging =
                                    FirebaseMessaging.instance;

                                String? fcm;
                                if (kIsWeb) {
                                  // Web testing
                                  fcm = "dummy_web_token";
                                } else if (Platform.isIOS) {
                                  // iOS simulator cannot fetch a real token
                                  fcm = "dummy_ios_token_for_testing";
                                } else {
                                  // Android or real iOS device
                                  try {
                                    fcm = await messaging.getToken();
                                  } catch (e) {
                                    print("❌ FCM token fetch failed: $e");
                                    fcm = "dummy_fallback_token";
                                  }
                                }
                                if (restaurantName.isNotEmpty &&
                                    restaurantEmail.isNotEmpty &&
                                    restaurantPhone.isNotEmpty &&
                                    restaurantAddress.isNotEmpty &&
                                    latitude != null &&
                                    longitude != null &&
                                    postalCode != null) {
                                  CreateRestaurant model = CreateRestaurant(
                                    title: restaurantName,
                                    userId: userId,
                                    imageUrl: uploadController.logoUrl,
                                    logoUrl: uploadController.logoUrl,
                                    restaurantFcm: fcm ?? "",
                                    // accountName: '1',
                                    // accountNumber: '1',
                                    // bank: '1',
                                    restaurantMail: restaurantEmail,
                                    phone: restaurantPhone,
                                    code: postalCode,
                                    latitude: latitude,
                                    longitude: longitude,
                                    address: restaurantAddress,
                                    addressTitle: "osogbo",
                                    latitudeDelta: 0.1222222,
                                    longitudeDelta: 0.122222,
                                  );

                                  String data = createRestaurantToJson(model);
                                  print("data: ${data}");

                                  int? statusCode =
                                      await controller.createRestaurant(data);

                                  if (statusCode == 201) {
                                    print("Restaurant created successfully.");
                                    Get.back();

                                    // await Future.delayed(const Duration(seconds: 2));
                                  } else {
                                    print(
                                        "Failed to create restaurant. Status code: $statusCode");
                                  }
                                }
                              }
                            : () {
                                Fluttertoast.showToast(
                                    msg: 'something went wrong');
                              },
                      ),
                    ),
                    SizedBox(height: 50.h)
                  ],
                ),
              ),
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
