
import 'package:vendor/common/size.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/fetch_packs.dart';
import 'package:vendor/models/hooks_model/hook_result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


FetchHook useFetchAllPacks(String id) {
  final packs = useState<List<FetchPackModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      final  url = Uri.parse("$appBaseUrl/api/pack/$id");    
      
      final response = await http.get(url);
      print("useFetchAllPacks: ${response.statusCode}");
      print("useFetchAllPacks_ url: ${url}");
      print("useFetchAllPacks: ${response.body}");
      
      
      
      if(response.statusCode == 200){
        packs.value =   fetchPackModelFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
    debugPrint(e.toString());
    //error.value = e as Exception;
  
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
    data: packs.value, 
    isLoading: isLoading.value, 
    error: error.value, 
    refetch: refetch,
  );
}