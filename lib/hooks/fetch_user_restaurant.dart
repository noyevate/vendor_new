
import 'package:vendor/common/size.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/fetch_user_restaurant.dart';
import 'package:vendor/models/hooks_model/hook_result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

FetchHook useFetchUserRestaurant(String id) {
  final resturant = useState<FetchUserRestaurantModel?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);


  final box = GetStorage(); // Initialize GetStorage
  
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      final url = Uri.parse("$appBaseUrl/api/restaurant/byUserId/$id");
      final response = await http.get(url);
      
      print("useFetch Restaurant Status Code: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        
        // Handle JSON safely in case of unexpected null values
        resturant.value = fetchUserRestaurantModelFromJson(response.body);
          box.write('restaurantId', resturant.value!.id);
          box.write('code', resturant.value!.code);
          print("Stored restaurantId: ${box.read('restaurantId')}");
      } else {
        // Log API error response
        apiError.value = apiErrorFromJson(response.body);
        print("API Error: ${apiError.value}");
      }
    } catch (e, stackTrace) {
      error.value = Exception("Failed to fetch restaurant data: $e");
      print("Exception: $e\n$stackTrace");
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: resturant.value, 
    isLoading: isLoading.value, 
    error: error.value, 
    refetch: refetch,
  );
}
