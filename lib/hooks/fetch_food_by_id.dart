import 'dart:convert';

import 'package:vendor/common/size.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/food_model.dart';
import 'package:vendor/models/hooks_model/single_food_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

FetchSingleFoods useFetchSingleFood(String id) {
  final food = useState<FoodModel?>(null); // Corrected declaration
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      final url = Uri.parse("$appBaseUrl/api/food/$id");
      final response = await http.get(url);
      print("useFetchSingleFoods: ${response.body}");

      if (response.statusCode == 200) {
        var singleFood = jsonDecode(response.body);
        food.value = FoodModel.fromJson(singleFood);
        print("useFetchSingleFoods: ${response.statusCode}");
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      error.value = e is Exception ? e : Exception('Unknown error');
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []); // Added dependency on id

  void refetch() {
    fetchData();
  }

  return FetchSingleFoods(
    data: food.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
