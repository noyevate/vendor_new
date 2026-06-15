// ignore_for_file: prefer_final_fields, file_names

import 'dart:convert';

import 'package:vendor/common/size.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/order_model.dart';
import 'package:vendor/models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class BusinesInsightController extends GetxController {
  final box = GetStorage();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  var totalOrder = 0.obs;
  var totalAmount = 0.obs;
  var rejectedOrder = 0.obs;
  var activeOrder = 0.obs;
  RxBool showCustomDateFields = false.obs;
  RxString filterName = "".obs;
    RxMap<String, List<RatingModel>> groupedRatings = <String, List<RatingModel>>{}.obs;


  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  set setLoading(bool newState) {
    _isLoading.value = newState;
    showCustomDateFields.value = false;
  }

  void clearField() {
    startDateController.text = "";
    endDateController.text = "";
    showCustomDateFields.value = false;
  }

  // Method to initialize with fetched data
  void initializeInsightData(List<OrderModel> orders) {
    totalOrder.value = orders.length;
    totalAmount.value =
        orders.fold(0, (sum, order) => sum + (order.orderTotal));
    rejectedOrder.value =
        orders.where((order) => order.orderStatus == 'Cancelled').length;
    activeOrder.value =
        orders.where((order) => order.orderStatus == 'Preparing').length;
    filterName.value = "All time";
  }

  void updateInsightData(List<OrderModel> orders, String name) {
    totalOrder.value = orders.length;
    totalAmount.value =
        orders.fold(0, (sum, order) => sum + (order.orderTotal));
    rejectedOrder.value =
        orders.where((order) => order.orderStatus == 'Cancelled').length;
    activeOrder.value =
        orders.where((order) => order.orderStatus == 'Preparing').length;
    filterName.value = name;
  }

  // Custom date

  void applyCustomDateFilter(List<OrderModel> order) {
    // Parse the dates from the text fields
    try {
      print(startDateController.text);
      String startDateText = startDateController.text.replaceAll('/', '-');
      String endDateText = endDateController.text.replaceAll('/', '-');
      print(startDateText);
      DateTime startDate = DateTime.parse(startDateText);
      DateTime endDate = DateTime.parse(endDateText);
      print(startDate.toString());

      // Filter orders by custom date range

      List<OrderModel> customDateOrders = order.where((order) {
        DateTime orderDate =
            order.createdAt; // Assuming `orderDate` is a String
        return orderDate.isAfter(startDate) && orderDate.isBefore(endDate);
      }).toList();

      print(customDateOrders);

      updateInsightData(customDateOrders, "Custom Filter");
    } catch (e) {
      Get.snackbar(
          "Invalid Dates", "Please enter valid dates in YYYY-MM-DD format.");
    }
  }

  // Current week
  List<OrderModel> getWeeklyOrders(List<OrderModel> orders) {
    // Get the start and end of the current week
    DateTime now = DateTime.now();
    DateTime startOfWeek =
        now.subtract(Duration(days: now.weekday - 1)); // Monday
    DateTime endOfWeek = startOfWeek.add(
        const Duration(days: 6, hours: 23, minutes: 59, seconds: 59)); // Sunday

    // Filter orders for the current week
    return orders.where((order) {
      return order.createdAt.isAfter(startOfWeek) &&
          order.createdAt.isBefore(endOfWeek);
    }).toList();
  }

  // Last week
  List<OrderModel> getLastWeekOrders(List<OrderModel> orders) {
    DateTime now = DateTime.now();

    // Start and end of last week
    DateTime startOfLastWeek = DateTime(now.year, now.month, now.day).subtract(
        Duration(days: now.weekday + 6)); // Start of Monday of last week
    DateTime endOfLastWeek = startOfLastWeek.add(const Duration(
        days: 6,
        hours: 23,
        minutes: 59,
        seconds: 59)); // End of Sunday of last week

    return orders.where((order) {
      return order.createdAt
              .isAfter(startOfLastWeek.subtract(const Duration(seconds: 1))) &&
          order.createdAt
              .isBefore(endOfLastWeek.add(const Duration(seconds: 1)));
    }).toList();
  }

  // Current week
  List<OrderModel> getCurrentMonthOrders(List<OrderModel> orders) {
    DateTime now = DateTime.now();

    // Start of the current month
    DateTime startOfMonth = DateTime(now.year, now.month, 1);

    // End of the current month
    DateTime endOfMonth = DateTime(
      now.year,
      now.month + 1,
      1,
    ).subtract(const Duration(seconds: 1));

    return orders.where((order) {
      return order.createdAt
              .isAfter(startOfMonth.subtract(const Duration(seconds: 1))) &&
          order.createdAt.isBefore(endOfMonth.add(const Duration(seconds: 1)));
    }).toList();
  }

  // Last Month
  List<OrderModel> getLastMonthOrders(List<OrderModel> orders) {
    DateTime now = DateTime.now();

    // Start of last month
    DateTime startOfLastMonth = DateTime(now.year, now.month - 1, 1);

    // End of last month
    DateTime endOfLastMonth =
        DateTime(now.year, now.month, 1).subtract(const Duration(seconds: 1));

    return orders.where((order) {
      return order.createdAt
              .isAfter(startOfLastMonth.subtract(const Duration(seconds: 1))) &&
          order.createdAt
              .isBefore(endOfLastMonth.add(const Duration(seconds: 1)));
    }).toList();
  }

  // Current Year
  List<OrderModel> getCurrentYearOrders(List<OrderModel> orders) {
    DateTime now = DateTime.now();

    // Start of the current year
    DateTime startOfCurrentYear = DateTime(now.year, 1, 1);

    // End of the current year
    DateTime endOfCurrentYear = DateTime(now.year, 12, 31, 23, 59, 59);

    return orders.where((order) {
      return order.createdAt.isAfter(
              startOfCurrentYear.subtract(const Duration(seconds: 1))) &&
          order.createdAt
              .isBefore(endOfCurrentYear.add(const Duration(seconds: 1)));
    }).toList();
  }

// last year
  List<OrderModel> getLastYearOrders(List<OrderModel> orders) {
    DateTime now = DateTime.now();

    // Start of last year
    DateTime startOfLastYear = DateTime(now.year - 1, 1, 1);

    // End of last year
    DateTime endOfLastYear = DateTime(now.year - 1, 12, 31, 23, 59, 59);

    return orders.where((order) {
      return order.createdAt
              .isAfter(startOfLastYear.subtract(const Duration(seconds: 1))) &&
          order.createdAt
              .isBefore(endOfLastYear.add(const Duration(seconds: 1)));
    }).toList();
  }

  Future<List<RatingModel>> fetchRestaurantRating(String restaurantId) async {
    setLoading = true;

    // String accessToken = box.read("token");
    var url = Uri.parse("$appBaseUrl/api/rating?restaurantId=$restaurantId");

    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   // 'Authorization': 'Bearer $accessToken'
    // };

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        
        print(response.body);
        var data =
            json.decode(response.body); // Assuming the API response is JSON
            setLoading = false;
        return List<RatingModel>.from(
            data.map((item) => RatingModel.fromJson(item)));
            
      } else {
        var error = apiErrorFromJson(response.body);
        print(error);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
    }
    return [];
  }

  Map<String, List<RatingModel>> groupRatingsByRange(
      List<RatingModel> ratings) {
    final Map<String, List<RatingModel>> groupedRatings = {
      "0.0–1.4": [],
      "1.5–2.4": [],
      "2.5–3.4": [],
      "3.5–4.4": [],
      "4.5–5.0": [],
      "0.0-5.0": []
      
    };

    groupedRatings["0.0–1.4"] = ratings
        .where((rating) => rating.rating >= 0.0 && rating.rating < 1.5)
        .toList();

    groupedRatings["1.5–2.4"] = ratings
        .where((rating) => rating.rating >= 1.5 && rating.rating < 2.5)
        .toList();

    groupedRatings["2.5–3.4"] = ratings
        .where((rating) => rating.rating >= 2.5 && rating.rating < 3.5)
        .toList();
    
    groupedRatings["3.5–4.4"] = ratings
        .where((rating) => rating.rating >= 3.5 && rating.rating < 4.5)
        .toList();

    groupedRatings["4.5–5.0"] = ratings
        .where((rating) => rating.rating >= 4.5 && rating.rating < 5.1)
        .toList();

    groupedRatings["0.0-5.0"] =
        ratings.where((rating) => rating.rating >= 0.0 && rating.rating < 5.1).toList();

    return groupedRatings;
  }
}
