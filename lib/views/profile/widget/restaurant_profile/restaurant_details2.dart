// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/setup_field.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/profile_restaurant_setup.dart';
import 'package:vendor/controller/restaurant_setup_controller.dart';
import 'package:vendor/controller/uploader_controller.dart';
import 'package:vendor/models/create_restaurant_model.dart';
import 'package:vendor/models/fetch_user_restaurant.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/views/restaurant/widget/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';

class RestaurantDetails2 extends StatelessWidget {
  const RestaurantDetails2({super.key, this.refetch, this.restaurant});

  final Function()? refetch;
  final LoginResponseModel? restaurant;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantSetupController2());
    final uploadController = Get.put(UploaderController());
    var latitude;
    var longitude;
    var postalCode;

    var lng;
    var lat;
    final box = GetStorage();
    var userId = box.read("userID");
    var name = box.read("name");
    var address = box.read("address");

    final TextEditingController restaurantName =
        TextEditingController(text: restaurant?.ownedRestaurant?.title ?? '');
    final TextEditingController restaurantAddress =
        TextEditingController(text: restaurant?.ownedRestaurant?.address ?? '');
    final TextEditingController restaurantEmail = TextEditingController(
        text: restaurant?.ownedRestaurant?.restaurantMail ?? '');
    final TextEditingController restaurantphone =
        TextEditingController(text: restaurant?.ownedRestaurant?.phone ?? '');
    final TextEditingController accountName = TextEditingController(
        text: restaurant?.ownedRestaurant?.accountName ?? '');
    final TextEditingController accountNumber = TextEditingController(
        text: restaurant?.ownedRestaurant?.accountNumber ?? '');
    final TextEditingController bank =
        TextEditingController(text: restaurant?.ownedRestaurant?.bank ?? '');

    controller.restaurant_name.value =
        name ?? restaurant?.ownedRestaurant?.title;
    controller.restaurant_address.value =
        address ?? restaurant?.ownedRestaurant?.address;
    controller.restaurant_email.value =
        restaurant!.ownedRestaurant!.restaurantMail;
    controller.restaurant_phone.value = restaurant!.ownedRestaurant!.phone;

    void validateForm() {
      controller.isFormFilled.value = restaurantName.text.isNotEmpty;
      restaurantAddress.text.isNotEmpty &&
          restaurantEmail.text.isNotEmpty &&
          restaurantphone.text.isNotEmpty;
    }

    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: SafeArea(
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
          body: Container(
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
                                  color: Tcolor.BORDERImageUploadCircumference),
                              shape: BoxShape.circle,
                            ),
                            child: uploadController.logoUrl == ""
                                ? ClipOval(
                                    child: Image.network(
                                      restaurant!.ownedRestaurant!.logoUrl,
                                      width: 170.w,
                                      height: 170.h,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.broken_image,
                                            color: Tcolor.Primary_New,
                                            size: 50);
                                      },
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.network(
                                      uploadController.logoUrl,
                                      width: 170.w,
                                      height: 170.h,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.broken_image,
                                            color: Tcolor.Primary_New,
                                            size: 50);
                                      },
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
                                border:
                                    Border.all(color: Tcolor.BorderUploadIcon)),
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
                    controller: restaurantName,
                    hintText: "e.g Item 7",
                    onChanged: (value) {
                      controller.restaurant_name.value = value;
                    },
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
                    controller: restaurantAddress,
                    hintText: "e.g Phase 1 Road, Ilorin 240281, Kwara",
                    onChanged: (value) => validateForm(),
                    onTap: () async {
                      // Navigate to the address search page and wait for the result
                      var result =
                          await Get.to(() => const AddressSearchPage());

                      // If an address was selected, update the text field and store details
                      if (result != null) {
                        restaurantAddress.text = result['address'];
                        postalCode = result['postalCode'];
                        latitude = result['latitude'];
                        longitude = result['longitude'];
                      } else {
                        // restaurantAddress.value = restaurant!.title;
                        postalCode = restaurant!.ownedRestaurant!.code;
                        latitude = restaurant!.ownedRestaurant!.latitude;
                        longitude = restaurant!.ownedRestaurant!.longitude;
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
                    controller: restaurantEmail,
                    hintText: "e.g restaurant@example.com",
                    onChanged: (value) => validateForm(),
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
                    controller: restaurantphone,
                    hintText: "e.g 08164xxxxxx",
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => validateForm(),
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
                        child: uploadController.coverUrl == ""
                            ? ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.r),
                                    topRight: Radius.circular(30.r)),
                                child: Image.network(
                                  restaurant!.ownedRestaurant!.imageUrl,
                                  width: 170.w,
                                  height: 170.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Tcolor.Primary_New,
                                    );
                                  },
                                ),
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
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Tcolor.Primary_New,
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100.h,
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
                          SizedBox(
                            height: 10.h,
                          ),
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
                              title: "entice customers.",
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
                  GestureDetector(
                    onTap: () async {
                      final name = restaurantName.text;
                      final email = restaurantEmail.text;
                      final phone = restaurantphone.value.text;

                      final address = restaurantAddress.text;
                      final account_name = accountName.text;
                      final account_number = accountNumber.text;
                      final bnk_code = bank.text;
                      lat = restaurant!.ownedRestaurant!.latitude;
                      lng = restaurant!.ownedRestaurant!.longitude;

                      if (name.isNotEmpty &&
                          email.isNotEmpty &&
                          phone.isNotEmpty &&
                          address.isNotEmpty) {
                        CreateRestaurant model = CreateRestaurant(
                          title: name,
                          userId: userId,
                          imageUrl: uploadController.coverUrl == ""
                              ? restaurant!.ownedRestaurant!.imageUrl
                              : uploadController.coverUrl,
                          logoUrl: uploadController.logoUrl == ""
                              ? restaurant!.ownedRestaurant!.imageUrl
                              : uploadController.logoUrl,
                          restaurantMail: email,
                          phone: phone,
                          code: postalCode == null
                              ? restaurant!.ownedRestaurant!.code
                              : postalCode == "N/A"
                                  ? restaurant!.ownedRestaurant!.code
                                  : postalCode,
                          latitude: latitude ?? lat,
                          longitude: longitude ?? lng,
                          address: address,
                          addressTitle: "ilorin",
                          latitudeDelta: 0.1222222,
                          longitudeDelta: 0.122222,
                          restaurantFcm: '',
                          accountName: account_name,
                          accountNumber: account_number,
                          bank: bnk_code,
                        );

                        String data = createRestaurantToJson(model);
                        int? statusCode = await controller.update_Restaurant(
                            data, restaurant!.id);
                        if (statusCode == 201) {
                          await Future.delayed(const Duration(seconds: 3));
                          // Go back after the snackbar show
                        } else {
                          print(
                              "Failed to update restaurant. Status code: $statusCode");
                          // Handle other status codes or errors here
                        }
                      }
                    },
                    child: CustomButton(
                      title: "Save changes",
                      textColor: Tcolor.Text,
                      btnColor: Tcolor.PRIMARY_Button_color_2,
                      btnWidth: width,
                      btnHeight: 96.h,
                      raduis: 100.r,
                      fontSize: 32.sp,
                      showArrow: false,
                    ),
                  ),
                  SizedBox(height: 50.h)
                ],
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
