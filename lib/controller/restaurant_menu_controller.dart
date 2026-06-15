// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:math';

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/enty_point.dart';
import 'package:vendor/models/api_error.dart';
import 'package:vendor/models/create_additive_model.dart';
import 'package:vendor/models/fetch_additive_model.dart';
import 'package:vendor/models/fetch_packs.dart';
import 'package:vendor/models/filter_by_restaurant_category_model.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/models/newAdditiveMeal_model.dart';
import 'package:vendor/models/newPaclMeal_model.dart';
import 'package:vendor/views/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:http/http.dart' as http;

class RestaurantMenuController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  var isSwitched = false.obs; // Observable variable
  var newOrderCount = 0.obs; // Observable for new order count
  var orderCounts = [0, 0, 0, 0, 0].obs; // Assuming 5 types of orders

  final RxBool showMealAvalbilityChanged = false.obs;

  RxBool isAvailable = false.obs;

  TextEditingController mealName = TextEditingController();
  TextEditingController menuCategory = TextEditingController();
  TextEditingController mealDescription = TextEditingController();

  TextEditingController price = TextEditingController();
  TextEditingController priceDescription = TextEditingController();

  TextEditingController pack = TextEditingController();

  TextEditingController packName = TextEditingController();
  TextEditingController packPrice = TextEditingController();
  TextEditingController packDescription = TextEditingController();

  TextEditingController additiveCategory = TextEditingController();
  TextEditingController additiveName = TextEditingController();
  TextEditingController additivePrice = TextEditingController();

  TextEditingController additive = TextEditingController();

  var isAvailableSwitch = false.obs;

  var foodCategory = "".obs;
  var foodCategoryId = "".obs;

  RxList<FetchPackModel> _packTypes = <FetchPackModel>[].obs;
  RxList<FetchPackModel> get packTypes => _packTypes;

  set setTypes(FetchPackModel newVale) {
    _packTypes.add(newVale);
    // updateMenuItem();
  }

  // Selecting from preexisting additives

  RxList<FetchAdditiveModel> _additives = <FetchAdditiveModel>[].obs;
  RxList<FetchAdditiveModel> get additives => _additives;

  set setAdditiveTypes(FetchAdditiveModel newVale) {
    _additives.add(newVale);
    updateAdditiveItem();
  }

  void clearTypes() {
    _additives.clear();
    updateAdditiveItem();
  }

  //  Creating new Additives

  RxList<NewAdditiveMealPage> _newAdditives = <NewAdditiveMealPage>[].obs;
  RxList<NewAdditiveMealPage> get newAdditives => _newAdditives;

  set setNewAdditiveTypes(NewAdditiveMealPage newVale) {
    _newAdditives.add(newVale);
    updateAdditiveItem();
  }

  void clearNewAdditivesTypes() {
    _additives.clear();
    updateAdditiveItem();
  }

  // adding new pack

  RxList<NewPackMealPage> _newPacks = <NewPackMealPage>[].obs;
  RxList<NewPackMealPage> get newPacks => _newPacks;

  set setNewPackTypes(NewPackMealPage newVale) {
    _newPacks.add(newVale);
  }

  void clearNewPackTypes() {
    _newPacks.clear();
  }

  void clearPacks() {
    pack.text = "";
    packDescription.text = "";
    packName.text = "";
    packPrice.text = "";
    packTypes.clear();
    newPacks.clear();
  }

  RxList<AdditiveOption> _optionsList = <AdditiveOption>[].obs;
  RxList<AdditiveOption> get optionList => _optionsList;
  set addAdditive(AdditiveOption newValue) {
    _optionsList.add(newValue);
  }

  void clearAdditives() {
    additives.clear();
    _newAdditives.clear();
    _optionsList.clear();
    additiveName.text = "";
    additivePrice.text = "";
    additiveCategory.text = "";
    additive.text = "";
  }

  void updateAdditiveItem() {
    // Update the TextEditingController with the count of types
    additive.text = "";
    if (_additives.isNotEmpty) {
      additive.text = "${_additives.length} selected";
    } else if (_newAdditives.isNotEmpty) {
      additive.text = "${_newAdditives.length} selected";
    }
  }

  TabController? tabController;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  void setTabController(TabController controller) {
    tabController = controller;
  }

  var isButtonActive = false.obs; // To track the button's active state

  // Logic to update button state
  void updateButtonState() {
    if (isSwitched.value && menuCategory.text.isNotEmpty) {
      isButtonActive.value = true;
    } else {
      isButtonActive.value = false;
    }
  }

  // Listen for text field changes
  void onTextFieldChanged(String text) {
    updateButtonState();
  }

  // Toggle the switch and update button state
  void toggleSwitch(bool value) {
    isSwitched.value = value;
    updateButtonState();
  }

  toggleAdditiveSwitch(bool value) {
    isAvailable.value = value;
    return value;
  }

  int generateId() {
    int min = 0;
    int max = 100000000;

    // ignore: unused_local_variable
    final _random = Random();
    return min + Random().nextInt(max - min);
  }

  RxList<RestaurantCategoryModel> _filteredList =
      <RestaurantCategoryModel>[].obs;
  RxList<RestaurantCategoryModel> get filteredList => _filteredList;

  set setFilteredMeal(RestaurantCategoryModel newVale) {
    _filteredList.add(newVale);
  }

  void clearFilteredMeal() {
    _filteredList.clear();
  }

  void reinitializeControllers() {
    // Dispose old ones
    mealName.dispose();
    menuCategory.dispose();
    mealDescription.dispose();
    price.dispose();
    priceDescription.dispose();
    pack.dispose();
    packName.dispose();
    packPrice.dispose();
    packDescription.dispose();
    additiveCategory.dispose();
    additiveName.dispose();
    additivePrice.dispose();
    additive.dispose();

    // Create fresh ones
    mealName = TextEditingController();
    menuCategory = TextEditingController();
    mealDescription = TextEditingController();
    price = TextEditingController();
    priceDescription = TextEditingController();
    pack = TextEditingController();
    packName = TextEditingController();
    packPrice = TextEditingController();
    packDescription = TextEditingController();
    additiveCategory = TextEditingController();
    additiveName = TextEditingController();
    additivePrice = TextEditingController();
    additive = TextEditingController();
  }

  void createMealFunction(String data) async {
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/food");
    final accessToken = box.read('token');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      var response = await http.post(url, headers: headers, body: data);
      debugPrint("food response: ${response.body}");
      if (response.statusCode == 201) {
        setLoading = false;
        Get.snackbar(
          "Food Created Successfully",
          "Bon appétit! Get ready to savor tasty treats with us.",
          colorText: Tcolor.Text,
          duration: const Duration(seconds: 4),
          backgroundColor: Tcolor.Primary,
          icon: const Icon(Ionicons.fast_food_outline),
        );

        // ✅ Reinitialize BEFORE navigating so new screen gets fresh controllers
        reinitializeControllers();
        additives.clear();
        packTypes.clear();
        optionList.clear();
        clearNewAdditivesTypes();
        clearNewPackTypes();
        foodCategory.value = "";

        final storedModel = box.read('loginModel');
        LoginResponseModel? loginModel;
        if (storedModel != null) {
          loginModel = LoginResponseModel.fromJson(
            storedModel is String ? jsonDecode(storedModel) : storedModel,
          );
        }

        Get.off(
          () => MainScreen(loginModel: loginModel),
          arguments: 1,
        );
      } else {
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Something went wrong",
          titleStyle: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: Tcolor.TEXT_Placeholder),
          middleText: error.message,
          middleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Tcolor.TEXT_Label),
          textConfirm: "OK",
          onConfirm: () {
            setLoading = false;
            Get.back();
          },
          barrierDismissible: false,
          confirmTextColor: Tcolor.Text,
          buttonColor: Tcolor.TEXT_Label,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showOrderTypeOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: 1500.h,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Tcolor.White,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReuseableText(
                    title: "Select Category",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 32.sp,
                        color: Tcolor.Text),
                  ),
                  Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Tcolor.BACKGROUND_Dark,
                      borderRadius: BorderRadius.circular(60.r),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          HeroiconsOutline.xMark,
                          color: Tcolor.Text,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Wrap(
                children: foodCategories.map((option) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: ReuseableText(
                      title: option,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 28.sp,
                          color: Tcolor.Text),
                    ),
                    onTap: () {
                      foodCategory.value = option; // Update observable value
                      Get.back(); // Close the bottom sheet
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to fetch categories from the backend

  Future<List<String>> fetchCategoriesFromBackend(String id) async {
    // Show loading
    setLoading = true;

    Uri url = Uri.parse("$appBaseUrl/api/food/restaurant-categories/$id");

    try {
      // Perform the GET request
      var response = await http.get(url);
      setLoading = false;
      debugPrint('restaurant category: ${response.body}');
      if (response.statusCode == 200) {
        // Parse the response data (list of strings in this case)
        print("Response body: ${response.body}");
        List<dynamic> responseData = jsonDecode(response.body);
        print("Parsed Response: $responseData");

        // Assuming responseData is a list of strings
        List<String> categories = List<String>.from(responseData);

        // Hide loading
        setLoading = false;

        return categories; // Return the list of categories
      } else {
        // Handle error responses
        var error = apiErrorFromJson(response.body);
        setLoading = false;
        throw Exception("Error fetching categories: ${error.message}");
      }
    } catch (e) {
      // Catch and print any other errors
      debugPrint("Error: ${e.toString()}");
      setLoading = false;
      return [];
    } finally {
      setLoading = false;
    }
  }

  // Future<void> isAvailable (bool value) async {
  //   isAvailableSwitch.value = value;

  //   // Make the API call here
  //   try {
  //     // Example API call (replace with your actual endpoint and logic)
  //     final response = await http.post(
  //       Uri.parse('https://your-api-url.com/toggle-status'),
  //       body: {'status': isSwitched.value.toString()},
  //     );

  //     if (response.statusCode == 200) {
  //       // Handle success
  //       print("API call successful");
  //     } else {
  //       // Handle error
  //       print("API call failed with status code: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     // Handle network error
  //     print("Error making API call: $e");
  //   }
  // }

  void updateFoodAvailability(
      String id, String restaurantCategory, Function refetch) async {
    setLoading = true;

    Uri url = Uri.parse(
        "$appBaseUrl/api/food/categoryAvailability/$id/$restaurantCategory");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.put(url, headers: headers);

      if (response.statusCode == 200) {
        Get.snackbar("Food Successfully",
            "Bon appétit! Get ready to savor tasty treats with us.",
            colorText: Tcolor.Text,
            duration: const Duration(seconds: 4),
            backgroundColor: Tcolor.Primary,
            icon: const Icon(Ionicons.fast_food_outline));

        refetch();

        showMealAvalbilityChanged.value = true;
        setLoading = false;

        // Get.back();
      } else {
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Something went wrong",
          titleStyle: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: Tcolor.TEXT_Placeholder),
          middleText: error.message,
          middleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Tcolor.TEXT_Label),
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
          barrierDismissible: false,
          confirmTextColor: Tcolor.Text,
          buttonColor: Tcolor.TEXT_Label,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateRestaurantCategoryName(String id, String currentCategory,
      String newCategory, Function refetch) async {
    setLoading = true;

    Uri url = Uri.parse(
        "$appBaseUrl/api/food/update-category/$id/$currentCategory/$newCategory");

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.patch(url, headers: headers);

      if (response.statusCode == 200) {
        Get.snackbar("Food Successfully",
            "Bon appétit! Get ready to savor tasty treats with us.",
            colorText: Tcolor.Text,
            duration: const Duration(seconds: 4),
            backgroundColor: Tcolor.Primary,
            icon: const Icon(Ionicons.fast_food_outline));

        refetch();

        showMealAvalbilityChanged.value = true;
        setLoading = false;

        // Get.back();
      } else {
        var error = apiErrorFromJson(response.body);
        Get.defaultDialog(
          backgroundColor: Tcolor.White,
          title: "Something went wrong",
          titleStyle: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: Tcolor.TEXT_Placeholder),
          middleText: error.message,
          middleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Tcolor.TEXT_Label),
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
          barrierDismissible: false,
          confirmTextColor: Tcolor.Text,
          buttonColor: Tcolor.TEXT_Label,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
