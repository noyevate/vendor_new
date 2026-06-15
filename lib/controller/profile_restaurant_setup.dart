// ignore_for_file: body_might_complete_normally_nullable, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:vendor/models/api_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';

import 'package:http/http.dart' as http;

class RestaurantSetupController2 extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  var isFormFilled = false.obs;
 var restaurant_name = "".obs;
 var restaurant_address = "".obs;
 var restaurant_email = "".obs;
 var restaurant_phone = "".obs;
  

  String coordGenerateId() {
    int min = 0;
    int max = 1000000;

    final _random = Random();
    int randomId = min + _random.nextInt(max - min);

    return randomId.toString();
  }
  

  Future<int?> update_Restaurant(String data, String id) async {
    setLoading = true;
    String accessToken = box.read("token");

    var url = Uri.parse("$appBaseUrl/api/restaurant/updateRestaurant/$id");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      var response = await http.put(url, headers: headers, body: data);
      print(data);
      print(response.statusCode);
      print("response.bod: ${response.body}");

      if (response.statusCode == 201) {

        var responseData = jsonDecode(response.body);
        var restaurant = responseData['updatedRestaurant'];
        print("restaurant: $restaurant");

        // Save data to GetStorage
        box.write('restaurantId', restaurant['id']);
        box.write('name', restaurant['title']);
        box.write('rating', restaurant['rating']);
        box.write('address', restaurant['address']);
        box.write('verification', restaurant['verification']);
        box.write('code', restaurant['code']);
        box.write('restaurant_email', restaurant['code']);
        Get.back();
        
        setLoading = false;
        Get.snackbar("Restaurant created Successfully",
            "We look forward to taking more orders from you",
            colorText: Tcolor.Text,
            duration: const Duration(seconds: 2),
            backgroundColor: Tcolor.Primary,
            icon: const Icon(Ionicons.fast_food_outline));
            Get.back();
            return 201; // Return status code 201 for success
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar("Adding restaurant detils Unsuccessful", error.message,
            colorText: Tcolor.White,
            duration: const Duration(seconds: 10),
            backgroundColor: Tcolor.SECONDARY_S3,
            icon: const Icon(Icons.error_outline));
      }
    } catch (e) {
      debugPrint(e.toString());
      setLoading = false;
    } finally {
      setLoading = false;
    }
  }

  // void onClose() {
  //   // restaurantName.dispose();
  //   restaurantAddress.dispose();
  //   restaurantEmail.dispose();
  //   restaurantphone.dispose();
  //   super.onClose();
  // }
  

}
