// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:math';

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/models/additive_model.dart';
// import 'package:vendor/models/additive_model.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/create_additive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AdditiveController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  RxBool isAvailable = false.obs;

  final RxBool showSdditiveOutOfStock = false.obs;
  final RxBool showAdditivDeleted = false.obs;
  final RxBool showAdditivCategoryDeleted = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  Function()? refetch;

  void setRefetch(Function()? fn) {
    refetch = fn;
  }

  RxList<AdditiveModel> _types = <AdditiveModel>[].obs;
  RxList<AdditiveModel> get types => _types;

  RxList<AdditiveModel> selectedTypeIds = <AdditiveModel>[].obs;

  RxList<AdditiveOption> _optionsList = <AdditiveOption>[].obs;

  RxList<AdditiveOption> get optionList => _optionsList;

  set addAdditive(AdditiveOption newValue) {
    _optionsList.add(newValue);
  }

  void clearAdditives() {
    _optionsList.clear();
    additiveName.text = "";
    additivePrice.text = "";
  }

  // Assuming you have the following properties in your controller
  TextEditingController additiveNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  set setTypes(AdditiveModel newVale) {
    _types.add(newVale);
    selectedTypeIds.add(newVale);
    updateMenuItem();
  }

  void clearTypes() {
    _types.clear();
    selectedTypeIds.clear();
    updateMenuItem();
  }

  final TextEditingController additiveCategory = TextEditingController();
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();
  final TextEditingController additiveName = TextEditingController();
  final TextEditingController additivePrice = TextEditingController();
  final TextEditingController menuItem = TextEditingController();

  int generateId() {
    int min = 0;
    int max = 100000000;

    // ignore: unused_local_variable
    final _random = Random();
    return min + Random().nextInt(max - min);
  }

  void updateMenuItem() {
    // Update the TextEditingController with the count of types
    _types.isEmpty
        ? menuItem.text = ""
        : menuItem.text = "${_types.length} selected";
  }

  @override
  void dispose() {
    additiveCategory.dispose();
    minController.dispose();
    maxController.dispose();
    additiveName.dispose();
    additivePrice.dispose();
    menuItem.dispose();
    super.dispose();
  }

  var isFormFilled = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add listeners to text controllers to track changes
    additiveCategory.addListener(onTextFieldChanged);
    minController.addListener(onTextFieldChanged);
    maxController.addListener(onTextFieldChanged);
  }

  @override
  void onClose() {
    additiveCategory.dispose();
    minController.dispose();
    maxController.dispose();
    super.onClose();
  }

  void updateButtonState() {
    if ( //minController.text.isNotEmpty &&
        maxController.text.isNotEmpty && additiveCategory.text.isNotEmpty) {
      isFormFilled.value = true;
    } else {
      isFormFilled.value = false;
    }
  }

  void onTextFieldChanged() {
    updateButtonState();
  }

  toggleSwitch(bool value) {
    isAvailable.value = value;
    return value;
  }

  Future<int?> createAdditiveFunction(String data, Function? refetch) async {
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/additive");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers, body: data);
      print("response: ${response.body}");
      setLoading = false;

      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        box.write('additiveId', responseData['_id']);
        print(box.read("additiveId"));
        clearAdditives();
        Get.back();

        refetch!();
        setLoading = false;

        Get.snackbar(
          "Additive Created Successfully",
          "Bon appétit! Get ready to savor tasty treats with us.",
          colorText: Tcolor.Text,
          duration: const Duration(seconds: 3),
          backgroundColor: Tcolor.Primary,
          icon: const Icon(Ionicons.fast_food_outline),
        );
      } else {
        setLoading = false;
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Something went wrong",
          titleStyle: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
            color: Tcolor.TEXT_Placeholder,
          ),
          middleText: error.message,
          middleTextStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: Tcolor.TEXT_Label,
          ),
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
          barrierDismissible: false,
          confirmTextColor: Tcolor.Text,
          buttonColor: Tcolor.TEXT_Label,
        );
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null; // Return null if an exception occurs
    }
    return null;
  }

  void editAdditiveCategory(String data, String id, Function refetch) async {
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/additive/additives/$id");

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

        // Get.back();
      } else {
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
      debugPrint(e.toString());
    }
  }

  void updateSingleAdditive(
      String data, String id, String optionId, Function refetch) async {
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/additive/additives/$id/$optionId");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.patch(url, headers: headers, body: data);
      print("response: ${response.body}");
      if (response.statusCode == 201) {
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
      debugPrint(e.toString());
    }
  }

  void updateAdditiveAvailability(String id, Function refetch) async {
    setLoading = true;

    Uri url =
        Uri.parse("$appBaseUrl/api/additive/additives/$id/toggle-availability");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        Get.snackbar("Additive Successfully",
            "Bon appétit! Get ready to savor tasty treats with us.",
            colorText: Tcolor.Text,
            duration: const Duration(seconds: 4),
            backgroundColor: Tcolor.Primary,
            icon: const Icon(Ionicons.fast_food_outline));

        refetch();

        showSdditiveOutOfStock.value = true;
        setLoading = false;

        // Get.back();
      } else {
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
      debugPrint(e.toString());
    }
  }

  void deleteAdditiveCategory(String id, Function refetch) async {
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/additive/additives/$id");

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

        showAdditivCategoryDeleted.value = true;
        setLoading = false;

        // Get.back();
      } else {
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
      debugPrint(e.toString());
    }
  }

  void deleteAdditiveOption(
      String id, String optionId, Function refetch) async {
    setLoading = true;

    Uri url = Uri.parse(
        "$appBaseUrl/api/additive/additives/removeAdditive/$id/$optionId");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        print("delete response: ${response.body}");
        Get.snackbar("Additive Successfully",
            "Bon appétit! Get ready to savor tasty treats with us.",
            colorText: Tcolor.Text,
            duration: const Duration(seconds: 4),
            backgroundColor: Tcolor.Primary,
            icon: const Icon(Ionicons.fast_food_outline));

        refetch();

        showAdditivCategoryDeleted.value = true;
        setLoading = false;

        // Get.back();
      } else {
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
      debugPrint(e.toString());
    }
  }
}
