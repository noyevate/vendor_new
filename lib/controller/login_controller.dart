// ignore_for_file: body_might_complete_normally_nullable, prefer_final_fields, unused_local_variable

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/payout_controller.dart';
import 'package:vendor/controller/restaurant_setup_controller.dart';
import 'package:vendor/enty_point.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/login_text_model.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/others/waiting_page.dart';
import 'package:vendor/views/auth/login/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import 'package:vendor/views/auth/widget/welcome_page.dart';
import 'package:vendor/views/restaurant/restaurant_seup/restaurant_profile_widgets/restaurant_details.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  final controller = Get.put(RestaurantSetupController());
  final accountcontroller = Get.put(PayoutController());

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  Future<void> login(String data) async {
    box.erase();

    setLoading = true;
    Uri url = Uri.parse("$appBaseUrl/vendor");
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers, body: data);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        LoginResponseModel responseData = LoginResponseModel.fromJson(data);
        debugPrint("modelling completed");
        box.write('loginModel', data);
        GetStorage().write('firstLaunch', false);

        // String userData = jsonEncode(responseData);

        box.write("token", responseData.userToken);
        box.write("userID", responseData.id);
        box.write("email", responseData.email);
        box.write("phone", responseData.phone);
        box.write("firstName", responseData.firstName);
        box.write("lastName", responseData.lastName);
        box.write("restaurantId", responseData.ownedRestaurant?.id);
        box.write("code", responseData.ownedRestaurant?.code);
        setLoading = false;

        debugPrint("running the if statements");
        if (responseData.ownedRestaurant != null &&
            (responseData.ownedRestaurant?.accountNumber?.isNotEmpty ??
                false) &&
            (responseData.ownedRestaurant?.accountName?.isNotEmpty ?? false)) {
          accountcontroller.isAccountDetails.value = true;
        }
        debugPrint("running the if statements for redirecting to the pages");
        if (responseData.ownedRestaurant != null) {
          debugPrint("herrrrrrrrrrrrr");
          switch (responseData.ownedRestaurant?.verification) {
            case null:
              controller.isRestaurant.value = true;
              if ((responseData.ownedRestaurant?.accountNumber?.isNotEmpty ??
                      false) &&
                  (responseData.ownedRestaurant?.accountName?.isNotEmpty ??
                      false)) {
                accountcontroller.isAccountDetails.value = true;
              }
              Get.offAll(() => WelcomePage(),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 700));
              break;

            case "Pending":
              controller.isRestaurant.value = true;
              if ((responseData.ownedRestaurant?.accountNumber?.isNotEmpty ??
                      false) &&
                  (responseData.ownedRestaurant?.accountName?.isNotEmpty ??
                      false)) {
                accountcontroller.isAccountDetails.value = true;
              }
              Get.offAll(() => MainScreen(loginModel: responseData),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 700));
              break;

            case "Verified":
              controller.isRestaurant.value = true;
              if ((responseData.ownedRestaurant?.accountNumber?.isNotEmpty ??
                      false) &&
                  (responseData.ownedRestaurant?.accountName?.isNotEmpty ??
                      false)) {
                accountcontroller.isAccountDetails.value = true;
              }
              Get.offAll(() => MainScreen(loginModel: responseData),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 700));
              break;

            default:
              break;
          }
        } else {
          print("something went erong ${responseData.verification}");
          // Get.offAll(
          //   () => const MainScreen(),
          //   transition: Transition.fadeIn,
          //   duration: const Duration(milliseconds: 700),
          // );
        }
        if (responseData.ownedRestaurant == null) {
          Get.offAll(
              () => MainScreen(
                    loginModel: responseData,
                  ),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 700));
        }

        // Get.offAll(
        //   () => const MainScreen(),
        //   transition: Transition.fadeIn,
        //   duration: const Duration(milliseconds: 700),
        // );
        Get.snackbar(
          'Success',
          'Logged in Successfully.',
          margin: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // Smaller margin
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 5), // Compact padding
          borderRadius: 8, // Rounded corners for a sleeker look
          // backgroundColor: Colors.black
          // .withOpacity(0.7), // Transparent background
          colorText: Tcolor.PRIMARY_S4,
          barBlur: 10, // Adds a blur effect
          duration: const Duration(seconds: 3), // Reduce display time
        );
      } else {
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Verification Failed",
          titleStyle: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: Tcolor.TEXT_Placeholder),
          middleText: error.message,
          middleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Tcolor.TEXT_Label),
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
          barrierDismissible: false,
          confirmTextColor: Tcolor.Text,
          buttonColor: Tcolor.TEXT_Label,
        );
        setLoading = false;
      }
    } catch (e) {
      debugPrint(e.toString());
      setLoading = false;
    }
  }

  void logout() {
    box.erase();
    Get.offAll(() => const LoginPage());
  }

  LoginResponseModel? getUserInfo() {
    String? userId = box.read('userId');
    String? data;
    if (userId != null) {
      data = box.read(userId);
      print(" this is the data id: ${data}");
    }

    if (data != null) {
      final Map<String, dynamic> str = jsonDecode(data);
      return LoginResponseModel.fromJson(str);
    }
    return null;
  }
}
