// ignore_for_file: prefer_final_fields

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/models/api_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import 'package:http/http.dart' as http;

class OperatingHoursController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  RxBool isAvailable = false.obs;
  RxBool isOperatingHours = false.obs;

  

  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  var isFormFilled = false.obs;

  var orderType = ''.obs; // Use RxString for reactive state
  var day = ''.obs;
  var open = ''.obs;
  var close = ''.obs;
  var orderCutOff = ''.obs;
  var menuReadyTime = ''.obs;
  // var restaurantPhone = ''.obs;

  List<String> orderTypeOptions = ["Instant delivery", "Pre-order"];

  void validateForm() {
    isFormFilled.value = orderType.value.isNotEmpty &&
        day.value.isNotEmpty &&
        open.value.isNotEmpty &&
        close.value.isNotEmpty;
  }

  // Method to handle showing bottom sheet and selecting an option
  void showOrderTypeOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: 1000.h,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Tcolor.White,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReuseableText(
                  title: "Order type",
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
              children: orderTypeOptions.map((option) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: ReuseableText(
                    title: option,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 28.sp,
                        color: Tcolor.Text),
                  ),
                  onTap: () {
                    orderType.value = option; // Update observable value
                    validateForm(); // Ensure form validation is triggered
                    Get.back(); // Close the bottom sheet
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void showTimePickerSheet(
      BuildContext context, Function(String) onTimeSelected) {
    showModalBottomSheet(
      backgroundColor: Tcolor.White,
      context: context,
      isScrollControlled: true, // To allow more height for the sheet
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (context) {
        // Generate time options dynamically
        List<String> times = [];
        for (int i = 9; i <= 21; i++) {
          String formattedTime = i > 12 ? '${i - 12} PM' : '$i AM';
          times.add(formattedTime);
        }

        return Container(
          height: 1000.h, // Adjust height as needed
          decoration: BoxDecoration(
            color: Tcolor.White,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.r),
              topLeft: Radius.circular(30.r),
            ),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReuseableText(
                title: "Select Time",
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  color: Tcolor.Text,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: times.length, // Use generated times list
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: ReuseableText(
                        title: times[index], // Display time from the list
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Tcolor.Text,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        onTimeSelected(times[index]); // Pass selected time
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<int?> addOperaingHours(String restaurantId, String data) async {
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/restaurant/addTime/$restaurantId");
    print("response: $url");

    String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      var response = await http.post(url, headers: headers, body: data);
      print("response: ${response.body}");
      print("response: ${response.statusCode}");
      setLoading = false;
      if (response.statusCode == 200) {
        isOperatingHours.value = true;
        Get.back();
        Get.snackbar(
          "",
          "",
          duration: const Duration(seconds: 3),
          backgroundColor: Tcolor.BACKGROUND_Regaular,
          titleText: ReuseableText(
            title: "Success",
            style: TextStyle(
                fontSize: 28.sp,
                color: Tcolor.Text,
                fontWeight: FontWeight.w600),
          ),
          messageText: ReuseableText(
            title: "Updating operating time successful",
            style: TextStyle(
                fontSize: 20.sp,
                color: Tcolor.Text_Secondary,
                fontWeight: FontWeight.w600),
          ),
        );
        return response.statusCode;
      } else {
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Updating operating time failed",
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
    return null;
  }
}
