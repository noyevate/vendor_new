// ignore_for_file: prefer_final_fields

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/models/api_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PackController extends GetxController {
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  RxBool isAvailable = false.obs;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  final TextEditingController packNameController = TextEditingController();
  final TextEditingController packDescriptionController =
      TextEditingController();
  final TextEditingController packPriceController = TextEditingController();

  // Observables
  var isFormFilled = false.obs;

  Function()? refetch;

  void setRefetch(Function()? fn) {
    refetch = fn;
  }

  // Dispose controllers
  @override
  void onClose() {
    packNameController.dispose();
    packDescriptionController.dispose();
    packPriceController.dispose();
    super.onClose();
  }

  toggleSwitch(bool value) {
    isAvailable.value = value;
    return value;
  }

  @override
  void onInit() {
    super.onInit();
    // Add listeners to text controllers to track changes
    packNameController.addListener(onTextFieldChanged);
    packDescriptionController.addListener(onTextFieldChanged);
    packPriceController.addListener(onTextFieldChanged);
  }

  void updateButtonState() {
    if (packNameController.text.isNotEmpty &&
        packDescriptionController.text.isNotEmpty &&
        packPriceController.text.isNotEmpty) {
      isFormFilled.value = true;
    } else {
      isFormFilled.value = false;
    }
  }

  void onTextFieldChanged() {
    updateButtonState();
  }

  Future<int?> createPackFunction(String data, Function refetch) async {
    setLoading = true;
    Uri url = Uri.parse("$appBaseUrl/api/pack");
    Map<String, String> headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(url, headers: headers, body: data);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        Get.back();
        refetch();

        

        packDescriptionController.text = "";
        packNameController.text = "";
        packPriceController.text = "";
        setLoading = false;
        Get.snackbar("Additive Created Successfully",
            "Bon appétit! Get ready to savor tasty treats with us.",
            colorText: Tcolor.Text,
            duration: const Duration(seconds: 4),
            backgroundColor: Tcolor.Primary,
            icon: const Icon(Ionicons.fast_food_outline));
            
        return response.statusCode;
      } else {
        setLoading = false;
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Something went wrong",
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
        return null; // Return null in case of failure
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
      return null; // Return null if an exception occurs
    }
  }

  void updatePack(String data, String id, Function refetch) async {
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/pack/update/$id");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.patch(url, headers: headers, body: data);
      print("response: ${response.body}");
      if (response.statusCode == 201) {
        Get.snackbar("Food Created Successfully",
            "Bon appétit! Get ready to savor tasty treats with us.",
            colorText: Tcolor.Text,
            duration: const Duration(seconds: 4),
            backgroundColor: Tcolor.Primary,
            icon: const Icon(Ionicons.fast_food_outline));

        refetch();
        setLoading = false;

        Get.back();
      } else {
        setLoading = false;
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Something went wrong",
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
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
    }
  }

  void deletePack(String id, Function refetch) async {
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/pack/delete/$id");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        print("delete response: $response");
        Get.snackbar("Additive Successfully",
            "Bon appétit! Get ready to savor tasty treats with us.",
            colorText: Tcolor.Text,
            duration: const Duration(seconds: 4),
            backgroundColor: Tcolor.Primary,
            icon: const Icon(Ionicons.fast_food_outline));

        refetch();

        setLoading = false;

        // Get.back();
      } else {
        setLoading = false;
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Something went wrong",
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
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
    }
  }

  Future<int?> createPackFunctionAtAddMealPage(String data) async {
    setLoading = true;
    Uri url = Uri.parse("$appBaseUrl/api/pack");
    Map<String, String> headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(url, headers: headers, body: data);
      print(response.body);
      print("create_pack_function_meal page:${response.statusCode}");
      if (response.statusCode == 201) {
        Get.back();
        packDescriptionController.text = "";
        packNameController.text = "";
        packPriceController.text = "";
        setLoading = false;
        Get.snackbar("Additive Created Successfully",
            "Bon appétit! Get ready to savor tasty treats with us.",
            colorText: Tcolor.Text,
            duration: const Duration(seconds: 4),
            backgroundColor: Tcolor.Primary,
            icon: const Icon(Ionicons.fast_food_outline));
            
        return response.statusCode;
      } else {
        setLoading = false;
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Something went wrong",
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
        return null; // Return null in case of failure
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
      return null; // Return null if an exception occurs
    }
  }
}
