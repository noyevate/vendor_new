// ignore_for_file: avoid_print
import 'package:get_storage/get_storage.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/hooks_model/hook_result.dart';
import 'package:vendor/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchRestaurantOrders(String restaurantId) {
  final box = GetStorage();
  final order = useState<List<OrderModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);


  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      
      final url = Uri.parse("$appBaseUrl/api/order/$restaurantId");
      String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
      print(url);
      final response = await http.get(url, headers: headers);


      print("restaurant order: ${response.body}");
      if (response.statusCode == 200) {
        
        order.value = orderModelFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    //Future.delayed(const Duration(seconds: 3));
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: order.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
