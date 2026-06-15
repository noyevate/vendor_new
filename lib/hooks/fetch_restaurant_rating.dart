// ignore_for_file: avoid_print

import 'package:vendor/common/size.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/hooks_model/hook_result.dart';
import 'package:vendor/models/rating_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchRestaurantRating(String restaurantId) {
  final restaurantRating = useState<List<RatingModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      final url =
          Uri.parse("$appBaseUrl/api/rating?restaurantId=$restaurantId");
      print(url.toString());
      final response = await http.get(url);
      print(" useFetchRestaurantRating: ${response.statusCode}");

      if (response.statusCode == 200) {
        restaurantRating.value = ratingModelFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      error.value = e as Exception;
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
    data: restaurantRating.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
