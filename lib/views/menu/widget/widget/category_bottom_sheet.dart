import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/restaurant_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class CategoryBottomSheet extends StatefulWidget {
  final RestaurantMenuController controller;
  final String? restaurantId;

  CategoryBottomSheet({required this.controller, this.restaurantId});

  @override
  _CategoryBottomSheetState createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {
  final box = GetStorage();
  List<String> categories = [];
  List<String> filteredCategories = [];
  bool isLoading = false;
  String query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCategories();
    });
  }

  // Function to fetch categories from backend
  void fetchCategories() async {
  // Guard clause to prevent null access
  if (widget.restaurantId == null) {
    debugPrint('restaurantId is null. Cannot fetch categories.');
    return;
  }

  setState(() {
    isLoading = true;
  });

  try {
    final fetchedCategories = await widget.controller
        .fetchCategoriesFromBackend(widget.restaurantId!);

    setState(() {
      categories = fetchedCategories;
      filteredCategories = categories;
      isLoading = false;
    });
  } catch (e) {
    debugPrint('Error fetching categories: $e');
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        color: Tcolor.White,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReuseableText(
                title: "Select Menu category",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32.sp,
                  color: Tcolor.Text,
                ),
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
                      isLoading = false;
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
          SizedBox(height: 20.h),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredCategories.isEmpty
                    ? Center(
                        child: ReuseableText(
                          title: "No Menu Category..",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400,
                            color: Tcolor.TEXT_Placeholder,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredCategories.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: ReuseableText(
                              title: filteredCategories[index],
                              style: TextStyle(
                                color: Tcolor.Text,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context, filteredCategories[index]);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

