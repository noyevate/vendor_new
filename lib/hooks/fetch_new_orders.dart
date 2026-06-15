
import 'package:get/get.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/order_controller.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/order_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/hooks_model/hook_result.dart';

FetchHook useFetchNewOrder(String id, String orderStatus, String paymentStatus) {
  final box = GetStorage();
  final order = useState<List<OrderModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);
  final orderController = Get.put(OrderController());

  // Using a variable to keep track of whether the hook is disposed
  bool isDisposed = false;

  Future<void> fetchData() async {
    if (isDisposed) return;  // Prevent any updates if disposed

    isLoading.value = true;

    try {
      final url = Uri.parse("$appBaseUrl/api/order/$id/$orderStatus/$paymentStatus");
      String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
      final response = await http.get(url, headers: headers,);
      print(id);
      print("Fetch new order status code: ${response.body}");
      
      

      if (response.statusCode == 200) {
        if (!isDisposed) {
          order.value = orderModelFromJson(response.body);
          orderController.orderLength.value = order.value!.length;
          print("order lenght: ${response.body.length}");
        }
      } else {
        if (!isDisposed) {
          apiError.value = apiErrorFromJson(response.body);
        }
      }
    } catch (e) {
      if (!isDisposed) {
        error.value = Exception(e.toString());
      }
    } finally {
      if (!isDisposed) {
        isLoading.value = false;
      }
    }
  }

  useEffect(() {
    fetchData();

    // Set up a dispose function
    return () {
      isDisposed = true;  // Mark as disposed when unmounting
    };
  }, []);

  void refetch() {
    if (!isDisposed) {
      isLoading.value = true;
      fetchData();
    }
  }

  return FetchHook(
    data: order.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
