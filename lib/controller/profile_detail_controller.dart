import 'dart:convert';

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/change_profile_name_model.dart';
import 'package:vendor/views/onboarding/walk_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileDetailController extends GetxController {
  final box = GetStorage();
  String get userId => box.read('userID');

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  set setLoading(bool value) {
    _isLoading.value = value;
  }

  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString phone = ''.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  var isFormFilled = false.obs;

  var errorMessage = ''.obs;
  var errorMessage1 = ''.obs;
  var oldPassword = ''.obs;
  var confirmPassword = "".obs;

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }

  void validateForm() {
    isFormFilled.value = oldPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();
    oldPasswordController
        .addListener(validateForm); // Call validateForm on email change
    newPasswordController.addListener(validateForm);
    confirmPasswordController.addListener(() {
      oldPassword.value = oldPasswordController.text;
      validateForm(); // Call validateForm on phone number change
    });

    debounce(
        oldPassword, (_) => checkPassword(oldPasswordController.text, userId),
        time: const Duration(milliseconds: 100));
    errorMessage.listen((_) {
      validateForm(); // Call validateForm whenever errorMessage changes
    });
  }

  void compareNewPassword(String newPass, String confirmPass) {
    print("cpmpare pass");
    if (newPass != confirmPass) {
      errorMessage1.value = "Password missmatch";
    } else {
      errorMessage1.value = "";
    }
    validateForm();
  }

  Future<void> checkPassword(String password, String id) async {
    final response = await http.post(
      Uri.parse(
          '$appBaseUrl/verify-password/$password/$id'), // Update with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'oldPassword': password,
      }),
    );

    if (response.statusCode == 400 || response.statusCode == 404) {
      final responseData = jsonDecode(response.body);
      errorMessage.value = responseData['message'];
    } else {
      errorMessage.value = '';
    }

    validateForm(); // Ensure this is called after updating the errorMessage
  }

  

  Future<int?> changeName(
      String id, String first_name, String last_name) async {
    setLoading = true;
    String accessToken = box.read("token");

    var url = Uri.parse(
        "$appBaseUrl/api/users/updateUserName/$id/$first_name/$last_name");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      var response = await http.put(url, headers: headers);
      if (response.statusCode == 200) {
        // Parse the response body into ChangeProfileName object
        ChangeProfileName data = changeProfileNameFromJson(response.body);
        _saveUserData(data);
        // Update the reactive variables
        firstName.value = data.updatedUser.firstName;
        lastName.value = data.updatedUser.lastName;
        Get.back;
        // Save the updated data to GetStorage
        Get.snackbar(
          "Profile name changed Successfully",
          "Bon appétit! Get ready to savor tasty treats with us.",
          colorText: Tcolor.Text,
          duration: const Duration(seconds: 2),
          backgroundColor: Tcolor.Primary,
          icon: const Icon(Ionicons.fast_food_outline),
        );
        return response.statusCode;
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Changing Profile name Unsuccessful",
          error.message,
          colorText: Tcolor.White,
          duration: const Duration(seconds: 3),
          backgroundColor: Tcolor.ERROR_Reg,
          icon: const Icon(Icons.error_outline),
        );
        print(error.message);
        return response.statusCode;
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "An error occurred while changing your profile name. Please try again.",
        colorText: Tcolor.White,
        duration: const Duration(seconds: 3),
        backgroundColor: Tcolor.ERROR_Reg,
        icon: const Icon(Icons.error_outline),
      );
      return 500;
    } finally {
      setLoading = false;
    }
  }

  Future<int?> changePhone(String id, String phone_number) async {
    setLoading = true;
    String accessToken = box.read("token");

    var url =
        Uri.parse("$appBaseUrl/api/users/updateUserName/$id/$phone_number");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      var response = await http.put(url, headers: headers);
      if (response.statusCode == 200) {
        print(response.statusCode);

        // Parse the response body into ChangeProfileName object
        ChangeProfileName data = changeProfileNameFromJson(response.body);

        // Update the reactive variables
        phone.value = data.updatedUser.phone;

        // Save the updated data to GetStorage
        _saveUserData(data);

        Get.snackbar(
          "Phone number changed Successfully",
          "Bon appétit! Get ready to savor tasty treats with us.",
          colorText: Tcolor.Text,
          duration: const Duration(seconds: 2),
          backgroundColor: Tcolor.Primary,
          icon: const Icon(Ionicons.fast_food_outline),
        );
        return response.statusCode;
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Phone number change Unsuccessful",
          error.message,
          colorText: Tcolor.White,
          duration: const Duration(seconds: 3),
          backgroundColor: Tcolor.ERROR_Reg,
          icon: const Icon(Icons.error_outline),
        );
        print(error.message);
        return response.statusCode;
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "An error occurred while changing your your Phonr number. Please try again.",
        colorText: Tcolor.White,
        duration: const Duration(seconds: 3),
        backgroundColor: Tcolor.ERROR_Reg,
        icon: const Icon(Icons.error_outline),
      );
      return 500;
    } finally {
      setLoading = false;
    }
  }

  Future<int?> changePassword(
      String id, String password, String password1) async {
    setLoading = true;
    String accessToken = box.read("token");

    var url = Uri.parse(
        "$appBaseUrl/api/users/resset-password/$id/$password/$password1");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      var response = await http.put(url, headers: headers);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Password changed Successfully",
          "Bon appétit! Get ready to savor tasty treats with us.",
          colorText: Tcolor.Text,
          duration: const Duration(seconds: 2),
          backgroundColor: Tcolor.Primary,
          icon: const Icon(Ionicons.fast_food_outline),
        );
        return response.statusCode;
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Phone number change Unsuccessful",
          error.message,
          colorText: Tcolor.White,
          duration: const Duration(seconds: 3),
          backgroundColor: Tcolor.ERROR_Reg,
          icon: const Icon(Icons.error_outline),
        );
        print(error.message);
        return response.statusCode;
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "An error occurred while changing your Password. Please try again.",
        colorText: Tcolor.White,
        duration: const Duration(seconds: 3),
        backgroundColor: Tcolor.ERROR_Reg,
        icon: const Icon(Icons.error_outline),
      );
      return 500;
    } finally {
      setLoading = false;
    }
  }

  void _saveUserData(ChangeProfileName data) {
    box.write("verification", data.updatedUser.phoneVerification);
    box.write("first_name", data.updatedUser.firstName);
    box.write("last_name", data.updatedUser.lastName);
    box.write("phone", data.updatedUser.phone);
    box.write("email", data.updatedUser.email);
  }



  Future<void> deleteAccount(String password, String id) async {
   
      setLoading = true;
      final accessToken = box.read("token");

      var url =
          Uri.parse('$appBaseUrl/verify-password/$password/$id');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      try {
        var response = await http.post(url, headers: headers);
        if (response.statusCode == 200) {
          // Navigator.pop(context);
          print(" pin verified: ${response.statusCode}");
          passwordController.text = "";
          setLoading = true;
          String accessToken = box.read("token");

          var url = Uri.parse("$appBaseUrl/api/users/deleteUser/$id");
          Map<String, String> headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          };
          try {
            var response = await http.delete(
              url,
              headers: headers,
            );
            if (response.statusCode == 200) {
              setLoading = false;
              Get.snackbar("Account Deleted",
                  "Bon appétit! Get ready to savor tasty treats with us.",
                  colorText: Tcolor.Text,
                  duration: const Duration(seconds: 2),
                  backgroundColor: Tcolor.Primary,
                  icon: const Icon(Ionicons.fast_food_outline));
              box.erase();
              Get.offAll(
                () => const WalkThrough(),
                transition: Transition.fade,
                duration: const Duration(milliseconds: 700),
              );
            } else {
              var error = apiErrorFromJson(response.body);
              Get.snackbar("Creating Order Unsuccessful", error.message,
                  colorText: Tcolor.White,
                  duration: const Duration(seconds: 3),
                  backgroundColor: Tcolor.ERROR_Light_1,
                  icon: const Icon(Icons.error_outline));
              print(error.message);
            }
          } catch (e) {
            debugPrint(e.toString());
          } finally {
            setLoading = false;
          }
        } else {
          var error = apiErrorFromJson(response.body);
          Get.snackbar(
            "Wrong Pin",
            error.message,
            colorText: Tcolor.White,
            duration: const Duration(seconds: 3),
            backgroundColor: Tcolor.ERROR_Reg,
            icon: const Icon(Icons.error_outline),
          );
          setLoading = false;
          print(error.message);
        }
      } catch (e) {
        debugPrint(e.toString());
        Get.snackbar(
          "Error",
          "An error occurred. Please try again.",
          colorText: Tcolor.White,
          duration: const Duration(seconds: 3),
          backgroundColor: Tcolor.ERROR_Reg,
          icon: const Icon(Icons.error_outline),
        );
        setLoading = false;
      } finally {
        setLoading = false;
      }
    
  }
}
