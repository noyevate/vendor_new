import 'dart:convert';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/single_resturant.dart';

class PayoutController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  var bank = <String, String>{}.obs;
  var isAccountDetails = false.obs;

  TextEditingController accountName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController restaurantphone = TextEditingController();

  void showOrderTypeOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: 1000.h,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Tcolor.White,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReuseableText(
                    title: "Select bank",
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
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Wrap(
                children: banks.map((option) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: ReuseableText(
                      title: option['name'] ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 28.sp,
                          color: Tcolor.Text),
                    ),
                    onTap: () {
                      bank.value = option; // Update observable value
                      Get.back(); // Close the bottom sheet
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<int?> addAccountDetails(String data, String restaurantId) async {
  //   setLoading = true;
  //   String accessToken = box.read("token");
  //   var url =
  //       Uri.parse("$appBaseUrl/api/restaurant/account_details/$restaurantId");
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $accessToken'
  //   };
  //   try {
  //     var response = await http.post(url, headers: headers, body: data);
  //     print(response.statusCode);
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       SingleRestaurant responseData = singleRestaurantFromJson(response.body);
  //       isAccountDetails.value = true;
  //       Get.back();
  //       setLoading = false;
  //       Get.snackbar("account details added Successfully",
  //           "We look forward to taking more orders from you",
  //           colorText: Tcolor.Text,
  //           duration: const Duration(seconds: 2),
  //           backgroundColor: Tcolor.Primary,
  //           icon: const Icon(Ionicons.fast_food_outline));
  //       return 200;
  //     } else {
  //       var error = apiErrorFromJson(response.body);
  //       Get.snackbar("Adding account detils Unsuccessful", error.message,
  //           colorText: Tcolor.White,
  //           duration: const Duration(seconds: 10),
  //           backgroundColor: Tcolor.SECONDARY_S3,
  //           icon: const Icon(Icons.error_outline));
  //       setLoading = false;
  //       return response.statusCode;
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return null;
  //   } finally {
  //     setLoading = false;
  //   }
  // }

  Future<int?> addAccountDetails(String data, String restaurantId) async {
    setLoading = true;
    String accessToken = box.read("token");
    var url =
        Uri.parse("$appBaseUrl/api/restaurant/account_details/$restaurantId");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      var response = await http.post(url, headers: headers, body: data);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        isAccountDetails.value = true;
        Get.back;
        // ✅ No parsing — we don't need the response body here
        return 200;
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Error",
          error.message,
          colorText: Tcolor.White,
          duration: const Duration(seconds: 5),
          backgroundColor: Tcolor.SECONDARY_S3,
          icon: const Icon(Icons.error_outline),
        );
        return response.statusCode;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      setLoading = false;
    }
  }
}
