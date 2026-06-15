import 'dart:convert';

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/models/api_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  final box = GetStorage();
  // ignore: prefer_final_fields
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  var isSwitched = false.obs; // Observable variable
  var newOrderCount = 0.obs; // Observable for new order count
  RxList<int> orderCounts =
      <int>[0, 0, 0, 0, 0].obs; // Assuming 5 types of orders

  var loading = false.obs;

  var orderLength = 0.obs;

  var showOrderRejected = false.obs;
  TabController? tabController;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  void setTabController(TabController controller) {
    tabController = controller;
  }

  void setNewOrderCount(int count) {
    newOrderCount.value = count; // Update the count
  }

  void updateOrderCount(int index, int count) {
    if (index >= 0 && index < orderCounts.length) {
      orderCounts[index] = count;
    }
  }

  Future<void> toggleAvailability(String restaurantId, bool newValue) async {
    String accessToken = box.read("token");
    setLoading = true;

    var url = Uri.parse(
        '$appBaseUrl/api/restaurant/toggle-availability/$restaurantId');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      var response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        print('Successfully toggled availability');
        final data = jsonDecode(response.body);
        print(data);
        print(data['isAvailabe']);
        isSwitched.value =
            data['isAvailabe']; // Update switch only if API succeeds
      } else {
        print('Failed to toggle availability: ${response.reasonPhrase}');
        Get.snackbar(
          "Error",
          "Network error",
          colorText: Tcolor.Text,
          duration: const Duration(seconds: 3),
          backgroundColor: Tcolor.ERROR_Light_2,
          icon: const Icon(Ionicons.fast_food_outline),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      setLoading = false;
    } finally {
      setLoading = false;
    }
  }

// This function no longer directly updates the switch.
  void toggleSwitch(String restaurantId, bool value) {
    if (!loading.value) {
      toggleAvailability(restaurantId, value); // Only API decides switch state
    }
  }

  // Future<void> toggleAvailability(String restaurantId) async {
  //   String accessToken = box.read("token");
  //   setLoading = true;

  //   var url = Uri.parse('$appBaseUrl/api/restaurant/toggle-availability/$restaurantId');

  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $accessToken'
  //   };

  //   try {
  //     var response = await http.post(url, headers: headers);

  //     if (response.statusCode == 200) {
  //       print('Successfully toggled availability');
  //       final data = jsonDecode(response.body);
  //       isSwitched.value = data['isAvailable'];

  //     } else {
  //       print('Failed to toggle availability: ${response.reasonPhrase}');
  //       Get.snackbar(
  //         "Error",
  //         "Network error",
  //         colorText: Tcolor.Text,
  //         duration: const Duration(seconds: 3),
  //         backgroundColor: Tcolor.ERROR_Light_2,
  //         icon: const Icon(Ionicons.fast_food_outline),
  //       );
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //   } finally {
  //     setLoading = false;
  //   }
  // }

  // void toggleSwitch(bool value, restaurantId) {
  //   isSwitched.value = value;
  //   toggleAvailability(restaurantId); // Replace with dynamic restaurant ID
  // }

  void rejectOrder(String id, String orderStatus, Function refetch) async {
    setLoading = true;
    // String accessToken = box.read("token");

    var url =
        Uri.parse("$appBaseUrl/api/order/updateOrderStatus/$id/$orderStatus");
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $accessToken'
    // };
    try {
      var response = await http.patch(url);

      if (response.statusCode == 201) {
        print("rejecting statuscode: ${response.statusCode}");
        print(response.body);

        setLoading = false;
        refetch();
        showOrderRejected.value = true;
        Get.back();
      } else {
        var error = apiErrorFromJson(response.body);
        setLoading = false;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
    }
  }

  void navigateToTab(int index) {
    if (tabController != null) {
      tabController!.animateTo(index); // Smoothly navigate to the tab
    }
  }

  void acceptOrder(String id, String orderStatus) async {
    setLoading = true;

    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    //     String? fcm = await messaging.getToken();
    //     print("FCM Token: $fcm");

    //     if (fcm == null) {
    //       print("Error: Unable to get FCM Token");
    //       fcm = "No fcm yet";
    //     }

    String fcm = "No fcm yet";
    var url = Uri.parse(
        "$appBaseUrl/api/order/updateOrderStatus/$id/$orderStatus/$fcm");
    String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      var response = await http.patch(url, headers: headers);
      print(" url : $url");
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        int? tabIndex;
        if (orderStatus == "Preparing") {
          tabIndex = 1;
        } else if (orderStatus == "Ready") {
          tabIndex = 2;
        } else if (orderStatus == "Out_For_Delivery") {
          tabIndex = 3;
        } else if (orderStatus == "Cancelled") {
          tabIndex = 0;
        }

        navigateToTab(tabIndex!); // Navigate directly to the tab
        Get.back(); // Close the modal or pop the current page if needed
        setLoading = false;
      }
    } catch (e) {
      debugPrint(e.toString());
      setLoading = false;
    } finally {
      setLoading = false;
    }
  }

   Future<bool> verifyPickupPin(String orderId, String pin) async {
    // We need the restaurantId to authorize this action on the backend
    String restaurantId = box.read("restaurantId"); // Or however you store it
    String accessToken = box.read("token");
    bool isSuccess = false;
    
    setLoading = true; // Assuming you have a loading state

    var url = Uri.parse("$appBaseUrl/api/restaurant/verify-pickup/$orderId");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    
    // The PIN and authorizing restaurantId are sent in the body
    var body = jsonEncode({
      'pin': pin,
      'restaurantId': restaurantId
    });

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        int? tabIndex;
        tabIndex = 3;
        navigateToTab(tabIndex!); // Navigate directly to the tab
        Get.back(); 
        Get.snackbar(
          "Pickup Confirmed!",
          "The order is now on its way to the customer.",
          backgroundColor: Tcolor.Primary,
          colorText: Tcolor.White,
        );
        isSuccess = true;
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar("Verification Failed", error.message,
            backgroundColor: Tcolor.ERROR_Reg,
            colorText: Tcolor.White);
      }
    } catch (e) {
      Get.snackbar("Network Error", "Please check your connection and try again.");
      debugPrint(e.toString());
    } finally {
      setLoading=false;
    }
    
    return isSuccess;
  }

}


  // void acceptOrder(String id, String orderStatus) async {
  //   setLoading = true;

  //   var url =
  //       Uri.parse("$appBaseUrl/api/order/updateOrderStatus/$id/$orderStatus");

  //   try {
  //     var response = await http.patch(url);

  //     if (response.statusCode == 201) {
  //       print("accepting statuscode: ${response.statusCode}");
  //       print(response.body);
  //       if (orderStatus == "Preparing") {
  //         Get.off(() =>
  //             const OrderPage(selectedIndex: 1)); // Pass initial tab index
  //       } else if (orderStatus == "Ready") {
  //         Get.offAll(() =>
  //             const OrderPage(selectedIndex: 2)); // Pass initial tab index
  //       } else if (orderStatus == "Out_For_Delivery") {
  //         Get.offAll(() =>
  //             const OrderPage(selectedIndex: 3)); // Pass initial tab index
  //       } else if (orderStatus == "Cancelled") {
  //         Get.offAll(() =>
  //             const OrderPage(selectedIndex: 0)); // Pass initial tab index
  //       }
  //       setLoading = false;
  //       Get.back();
  //     } else {
  //       var error = apiErrorFromJson(response.body);
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   } finally {
  //     setLoading = false;
  //   }
  // }

  // String accessToken = box.read("token");

  // Map<String, String> headers = {
  //   'Content-Type': 'application/json',
  //   'Authorization': 'Bearer $accessToken'
  // };
// }
