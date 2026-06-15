
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  final box = GetStorage();
   RxString selectedAddress = ''.obs; // Add this line
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
  }

    void updateSelectedAddress(String newAddress) {
    selectedAddress.value = newAddress;
    // box.write('defaultAdd', newAddress); // Save to persistent storage
  }

  

  


  

  
}
