import 'package:vendor/common/size.dart';
import 'package:vendor/models/additive_model.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/hooks_model/hook_result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchCategories(String id) {
  final additives = useState<List<AdditiveModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      final url = Uri.parse("$appBaseUrl/api/food/additive/$id");
      
      final response = await http.get(url);
      print(" UseFetchAdditives: ${response.statusCode}");      
      if (response.statusCode == 200) {
        additives.value = additiveModelFromJson(response.body);
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
    data: additives.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
