// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/setup_field.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/restaurant_menu_controller.dart';
import 'package:vendor/controller/uploader_controller.dart';
import 'package:vendor/models/create_additive_model.dart';
import 'package:vendor/models/create_meal_model.dart';
import 'package:vendor/models/fetch_user_restaurant.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/models/newAdditiveMeal_model.dart';
import 'package:vendor/models/newPaclMeal_model.dart';
import 'package:vendor/models/pack_model.dart';
import 'package:vendor/views/menu/widget/widget/AddMealWidgets/choose_addtive.dart';
import 'package:vendor/views/menu/widget/widget/AddMealWidgets/choose_food_category.dart';
import 'package:vendor/views/menu/widget/widget/AddMealWidgets/choose_pack.dart';
import 'package:vendor/views/menu/widget/widget/add_additives.dart';
import 'package:vendor/views/menu/widget/widget/add_pack.dart';
import 'package:vendor/views/menu/widget/widget/category_bottom_sheet.dart';
import 'package:vendor/views/menu/widget/widget/create_new_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';

class AddMealWidget extends StatelessWidget {
  const AddMealWidget({super.key, this.restaurant});

  final LoginResponseModel? restaurant;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final restaurantId = box.read("restaurantId");
    final String code = box.read("code") ?? "240110";
    print("resturantID: $restaurantId");
    final uploadController = Get.put(UploaderController());
    final controller = Get.put(RestaurantMenuController(), permanent: true);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.h),
              child: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: const SafeArea(
                  child: Column(
                    children: [
                      PageTitle(
                        title: "Add meal",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        uploadController.pickImage("one");
                      },
                      child: Obx(
                        () => Container(
                          height: 270.h,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r)),
                              color: Tcolor.BACKGROUND_Regaular),
                          child: uploadController.imageOneUrl == ''
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                    Container(
                                      height: 100.h,
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Tcolor.BACKGROUND_Dark),
                                      child: Icon(
                                        HeroiconsOutline.camera,
                                        color: Tcolor.Text,
                                        size: 40.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    ReuseableText(
                                      title: "Upload cover image",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Body,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    ReuseableText(
                                      title:
                                          "JPG & PNG format of max size of 2MB",
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Label,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.r),
                                      topRight: Radius.circular(30.r)),
                                  child: Image.network(
                                    uploadController.imageOneUrl,
                                    width: 170.w,
                                    height: 170.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Container(
                      height: 100.h,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.r),
                              bottomRight: Radius.circular(30.r)),
                          color: Tcolor.SECONDARY_T2),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return Tcolor.SECONDARY_Button_gradient
                                        .createShader(bounds);
                                  },
                                  child: Icon(
                                    HeroiconsMini.informationCircle,
                                    size: 40.sp,
                                    color: Colors
                                        .white, // This color is irrelevant because the gradient shader will replace it
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                ReuseableText(
                                  title: "Eye-catching image of the meal",
                                  style: TextStyle(
                                    color: Tcolor.TEXT_Body,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    ReuseableText(
                      title: "Meal name",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SetupField(
                      sufixIcon: Icon(
                        HeroiconsOutline.chevronDown,
                        size: 28.sp,
                        color: Tcolor.BACKGROUND_Regaular,
                      ),
                      hintText: "e.g Ewa agoyin",
                      controller: controller.mealName,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    ReuseableText(
                      title: "Food category",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(() {
                      return GestureDetector(
                        child: SetupField(
                          sufixIcon: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Tcolor.White,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.r),
                                              topRight: Radius.circular(20.r))),
                                      height: 1150.h,
                                      width: width,
                                      child: const FoodCategory(),
                                    );
                                  });
                            },
                            child: Icon(
                              HeroiconsOutline.chevronDown,
                              size: 28.sp,
                              color: Tcolor.TEXT_Label,
                            ),
                          ),
                          controller: TextEditingController(
                              text: controller.foodCategory.value),
                          hintText: "Select category",
                          onChanged: (value) {
                            controller.foodCategory.value = value;
                          },
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Tcolor.White,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.r),
                                            topRight: Radius.circular(20.r))),
                                    height: 1150.h,
                                    width: width,
                                    child: const FoodCategory(),
                                  );
                                });
                          },
                        ),
                      );
                    }),
                    SizedBox(
                      height: 50.h,
                    ),
                    ReuseableText(
                      title: "Menu category",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SetupField(
                      controller: controller.menuCategory,
                      hintText: "Select category",
                      sufixIcon: GestureDetector(
                        onTap: () async {
                          // Open Bottom Sheet
                          String? selectedCategory =
                              await showModalBottomSheet<String>(
                            isDismissible: false,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return SizedBox(
                                  height: 1000.h,
                                  child: CategoryBottomSheet(
                                    controller: controller,
                                    restaurantId: restaurantId,
                                  ));
                            },
                          );
                          if (selectedCategory != null) {
                            // Update the category field with the selected category
                            controller.menuCategory.text = selectedCategory;
                          }
                        },
                        child: Icon(
                          HeroiconsOutline.chevronDown,
                          size: 28.sp,
                          color: Tcolor.TEXT_Label,
                        ),
                      ),
                      onTap: () async {
                        // Open Bottom Sheet
                        String? selectedCategory =
                            await showModalBottomSheet<String>(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return SizedBox(
                                height: 1000.h,
                                child: CategoryBottomSheet(
                                  controller: controller,
                                  restaurantId: restaurantId,
                                ));
                          },
                        );
                        if (selectedCategory != null) {
                          // Update the category field with the selected category
                          controller.menuCategory.text = selectedCategory;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<String>(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          builder: (context) {
                            return SizedBox(
                                height: 1150.h,
                                width: width,
                                child: const AddNewCategory());
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            HeroiconsOutline.plus,
                            size: 32.sp,
                            color: Tcolor.PRIMARY_S4,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          ReuseableText(
                            title: "Add menu category",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.sp,
                                color: Tcolor.PRIMARY_S4),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    ReuseableText(
                      title: "Description",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SetupField(
                      sufixIcon: Icon(
                        HeroiconsOutline.chevronDown,
                        size: 28.sp,
                        color: Tcolor.BACKGROUND_Regaular,
                      ),
                      hintText: "e.g Ewa agoyin and bread",
                      controller: controller.mealDescription,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 50.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                              title: "Price",
                              style: TextStyle(
                                color: Tcolor.TEXT_Label,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SetupField(
                              width: width / 2.5,
                              sufixIcon: Icon(
                                HeroiconsOutline.chevronDown,
                                size: 28.sp,
                                color: Tcolor.BACKGROUND_Regaular,
                              ),
                              hintText: "5000",
                              controller: controller.price,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                              title: "Description",
                              style: TextStyle(
                                color: Tcolor.TEXT_Label,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SetupField(
                              width: width / 2.5,
                              sufixIcon: Icon(
                                HeroiconsOutline.chevronDown,
                                size: 28.sp,
                                color: Tcolor.BACKGROUND_Regaular,
                              ),
                              hintText: "e.g per plate",
                              controller: controller.priceDescription,
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 50.h),
                    ReuseableText(
                      title: "Pack",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SetupField(
                      controller: controller.pack,
                      onTap: () {
                        showModalBottomSheet<String>(
                          context: context,
                          isScrollControlled: false,
                          isDismissible: false,
                          builder: (context) {
                            return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r)),
                                height: 900.h,
                                width: width,
                                child: const ChoosePack());
                          },
                        );
                      },
                      hintText: "Select pack",
                      sufixIcon: GestureDetector(
                        onTap: () async {
                          showModalBottomSheet<String>(
                            context: context,
                            isScrollControlled: false,
                            isDismissible: false,
                            builder: (context) {
                              return Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  height: 900.h,
                                  width: width,
                                  child: const ChoosePack());
                            },
                          );
                        },
                        child: Icon(
                          HeroiconsOutline.chevronDown,
                          size: 28.sp,
                          color: Tcolor.TEXT_Label,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () async {
                        final addPackData = await showModalBottomSheet<String>(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          builder: (context) {
                            return SizedBox(
                                height: 1150.h,
                                width: width,
                                child: const AddPack());
                          },
                        );

                        if (addPackData != null) {
                          // Parse the JSON string into a Map
                          final packMap =
                              jsonDecode(addPackData) as Map<String, dynamic>;

                          // Create an instance of CreateAdditiveModel from the map
                          NewPackMealPage newPacks =
                              NewPackMealPage.fromJson(packMap);

                          // Add the new additive to the list
                          controller.setNewPackTypes = newPacks;
                        } else {
                          print("something went wrong with the addPackData");
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            HeroiconsOutline.plus,
                            size: 32.sp,
                            color: Tcolor.PRIMARY_S4,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          ReuseableText(
                            title: "Add pack",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.sp,
                                color: Tcolor.PRIMARY_S4),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.h),
                    ReuseableText(
                      title: "Additives",
                      style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SetupField(
                              controller: controller.additive,
                              hintText: "Select additives",
                              sufixIcon: GestureDetector(
                                onTap: () async {
                                  // Open Bottom Sheet
                                  controller.clearTypes();
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      isDismissible: false,
                                      builder: (context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Tcolor.White,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.r),
                                                  topRight:
                                                      Radius.circular(20.r))),
                                          height: 1150.h,
                                          width: width,
                                          child: const ChooseAdditive(),
                                        );
                                      });
                                },
                                child: Icon(
                                  HeroiconsOutline.chevronDown,
                                  size: 28.sp,
                                  color: Tcolor.TEXT_Label,
                                ),
                              ),
                              onTap: () async {
                                // Open Bottom Sheet
                                controller.clearTypes();
                                controller.clearAdditives();
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Tcolor.White,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.r),
                                                topRight:
                                                    Radius.circular(20.r))),
                                        height: 1150.h,
                                        width: width,
                                        child: const ChooseAdditive(),
                                      );
                                    });
                              }),
                          SizedBox(height: 20.h),
                          controller.additives.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        controller.additives.length, (i) {
                                      return Container(
                                        height: 40.h,
                                        margin: EdgeInsets.only(right: 10.w),
                                        decoration: BoxDecoration(
                                          color: Tcolor.SECONDARY_S4,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: ReuseableText(
                                              title: controller
                                                  .additives[i].additiveTitle,
                                              style: TextStyle(
                                                  fontSize: 22.sp,
                                                  color: Tcolor.White,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () async {
                        print("add Aditive");

                        controller.clearAdditives();

                        final addAdditiveData =
                            await showModalBottomSheet<String>(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          builder: (context) {
                            return SizedBox(
                                height: 1150.h,
                                width: width,
                                child: const AddAdditives());
                          },
                        );
                        // Check if data was returned
                        if (addAdditiveData != null) {
                          // Parse the JSON string into a Map
                          final additiveMap = jsonDecode(addAdditiveData)
                              as Map<String, dynamic>;

                          // Create an instance of CreateAdditiveModel from the map
                          NewAdditiveMealPage newAdditive =
                              NewAdditiveMealPage.fromJson(additiveMap);

                          // Add the new additive to the list
                          controller.setNewAdditiveTypes = newAdditive;
                        } else {
                          print(
                              "something went wrong with the add new additives");
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            HeroiconsOutline.plus,
                            size: 32.sp,
                            color: Tcolor.PRIMARY_S4,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          ReuseableText(
                            title: "Add additive",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.sp,
                                color: Tcolor.PRIMARY_S4),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReuseableText(
                          title: "Mark item in stock",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 28.sp,
                            color: Tcolor.Text,
                          ),
                        ),
                        Obx(() => Transform.scale(
                              scale: 0.6,
                              child: Switch.adaptive(
                                value: controller.isSwitched.value,
                                onChanged: controller.toggleSwitch,
                                activeColor: const Color.fromRGBO(
                                    251, 178, 23, 1), // Active color
                                thumbColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors
                                        .white; // White thumb when active
                                  }
                                  return Tcolor
                                      .BACKGROUND_Regaular; // Regular thumb when inactive
                                }),
                                inactiveThumbColor:
                                    Tcolor.BACKGROUND_Dark, // Inactive color
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    GestureDetector(
                      onTap: () {
                        final mealName = controller.mealName.text;
                        final mealDescription = controller.mealDescription.text;
                        final mealCategory = controller.menuCategory.text;
                        int price = int.tryParse(controller.price.text) ?? 0;
                        var priceDescription = controller.priceDescription.text;
                        final foodCategory = controller.foodCategoryId.value;
                        final menuCategory =
                            controller.menuCategory.text.toLowerCase();
                        FocusScope.of(context).unfocus();

                        if (mealName.isNotEmpty &&
                            mealDescription.isNotEmpty &&
                            mealCategory.isNotEmpty &&
                            foodCategory.isNotEmpty &&
                            controller.packTypes.isNotEmpty &&
                            controller.additives.isNotEmpty) {
                          List<MealAdditive> mealAdditives =
                              controller.additives.map((additiveModel) {
                            return MealAdditive(
                              id: additiveModel.id,
                              restaurantId: additiveModel.restaurantId,
                              additiveTitle: additiveModel.additiveTitle,
                              options: additiveModel.options.map((option) {
                                return MealAdditiveOption(
                                  id: option.id,
                                  additiveName: option.additiveName,
                                  price: option.price,
                                  isAvailable: option.isAvailable,
                                );
                              }).toList(),
                              max: additiveModel.min,
                              min: additiveModel.max,
                              isAvailable: additiveModel.isAvailable,
                            );
                          }).toList();
                          List<MealPack> mealPack =
                              controller.packTypes.map((packs) {
                            return MealPack(
                                restaurantId: packs.restaurantId,
                                packName: packs.packName,
                                packDescription: packs.packDescription,
                                price: packs.price,
                                isAvailable: packs.isAvailable,
                                id: packs.id);
                          }).toList();

                          CreateFoodModel model = CreateFoodModel(
                              title: mealName,
                              time: "1",
                              foodTags: ["unknow"],
                              categoryId: foodCategory,
                              foodType: ["unknow"],
                              code: code,
                              isAvailable: controller.isSwitched.value,
                              restaurantId: restaurantId,
                              rating: 3.0,
                              ratingCount: "276",
                              description: mealDescription,
                              price: price,
                              priceDescription: priceDescription,
                              additive: mealAdditives,
                              pack: mealPack,
                              imageUrl: [uploadController.imageOneUrl],
                              restaurantCategory: menuCategory);
                          final String data = createFoodModelToJson(model);
                          debugPrint(data);
                          debugPrint(mealAdditives[0].id);
                          controller.createMealFunction(data);
                          priceDescription = "";
                          String priceString = price.toString();

                          priceString = "";
                        } else if (mealName.isNotEmpty &&
                            mealDescription.isNotEmpty &&
                            mealCategory.isNotEmpty &&
                            foodCategory.isNotEmpty &&
                            controller.packTypes.isEmpty &&
                            controller.additives.isEmpty &&
                            controller.newPacks.isNotEmpty &&
                            controller.newAdditives.isNotEmpty) {
                          List<MealAdditive> mealAdditives =
                              controller.newAdditives.map((additiveModel) {
                            return MealAdditive(
                                restaurantId: additiveModel.restaurantId,
                                additiveTitle: additiveModel.additiveTitle,
                                options: additiveModel.options.map((option) {
                                  return MealAdditiveOption(
                                    id: option.id,
                                    additiveName: option.additiveName,
                                    price: option.price,
                                    isAvailable: option.isAvailable,
                                  );
                                }).toList(),
                                max: additiveModel.min,
                                min: additiveModel.max,
                                isAvailable: additiveModel.isAvailable,
                                id: additiveModel.id);
                          }).toList();
                          List<MealPack> mealPack =
                              controller.newPacks.map((packs) {
                            return MealPack(
                                restaurantId: packs.restaurantId,
                                packName: packs.packName,
                                packDescription: packs.packDescription,
                                price: packs.price,
                                isAvailable: packs.isAvailable,
                                id: packs.id);
                          }).toList();

                          CreateFoodModel model = CreateFoodModel(
                              title: mealName,
                              time: "1",
                              foodTags: ["unknow"],
                              categoryId: foodCategory,
                              foodType: ["unknow"],
                              code: code,
                              isAvailable: controller.isSwitched.value,
                              restaurantId: restaurantId,
                              rating: 3.0,
                              ratingCount: "1",
                              description: mealDescription,
                              price: price,
                              priceDescription: priceDescription,
                              additive: mealAdditives,
                              pack: mealPack,
                              imageUrl: [uploadController.imageOneUrl],
                              restaurantCategory: menuCategory);
                          final String data = createFoodModelToJson(model);
                          controller.createMealFunction(data);
                          debugPrint(data);
                          debugPrint(mealAdditives[0].id);
                          priceDescription = "";
                          String priceString = price.toString();

                          priceString = "";
                        } else if (mealName.isNotEmpty &&
                            mealDescription.isNotEmpty &&
                            mealCategory.isNotEmpty &&
                            foodCategory.isNotEmpty &&
                            controller.packTypes.isNotEmpty &&
                            controller.additives.isEmpty &&
                            controller.newPacks.isEmpty &&
                            controller.newAdditives.isNotEmpty) {
                          List<MealAdditive> mealAdditives =
                              controller.newAdditives.map((additiveModel) {
                            return MealAdditive(
                                restaurantId: additiveModel.restaurantId,
                                additiveTitle: additiveModel.additiveTitle,
                                options: additiveModel.options.map((option) {
                                  return MealAdditiveOption(
                                    id: option.id,
                                    additiveName: option.additiveName,
                                    price: option.price,
                                    isAvailable: option.isAvailable,
                                  );
                                }).toList(),
                                max: additiveModel.min,
                                min: additiveModel.max,
                                isAvailable: additiveModel.isAvailable,
                                id: additiveModel.id);
                          }).toList();
                          List<MealPack> mealPack =
                              controller.packTypes.map((packs) {
                            return MealPack(
                                restaurantId: packs.restaurantId,
                                packName: packs.packName,
                                packDescription: packs.packDescription,
                                price: packs.price,
                                isAvailable: packs.isAvailable,
                                id: packs.id);
                          }).toList();
                          CreateFoodModel model = CreateFoodModel(
                              title: mealName,
                              time: "1",
                              foodTags: ["unknow"],
                              categoryId: foodCategory,
                              foodType: ["unknow"],
                              code: code,
                              isAvailable: controller.isSwitched.value,
                              restaurantId: restaurantId,
                              rating: 3.0,
                              ratingCount: "276",
                              description: mealDescription,
                              price: price,
                              priceDescription: priceDescription,
                              additive: mealAdditives,
                              pack: mealPack,
                              imageUrl: [uploadController.imageOneUrl],
                              restaurantCategory: menuCategory);
                          final String data = createFoodModelToJson(model);
                          debugPrint(data);
                          debugPrint(mealAdditives[0].id);
                          controller.createMealFunction(data);
                          priceDescription = "";
                          String priceString = price.toString();

                          priceString = "";
                        } else if (mealName.isNotEmpty &&
                            mealDescription.isNotEmpty &&
                            mealCategory.isNotEmpty &&
                            foodCategory.isNotEmpty &&
                            controller.packTypes.isEmpty &&
                            controller.additives.isNotEmpty &&
                            controller.newPacks.isNotEmpty &&
                            controller.newAdditives.isEmpty) {
                          print("newAdditives isEmpty");
                          List<MealAdditive> mealAdditives =
                              controller.additives.map((additiveModel) {
                            return MealAdditive(
                                restaurantId: additiveModel.restaurantId,
                                additiveTitle: additiveModel.additiveTitle,
                                options: additiveModel.options.map((option) {
                                  return MealAdditiveOption(
                                    id: option.id,
                                    additiveName: option.additiveName,
                                    price: option.price,
                                    isAvailable: option.isAvailable,
                                  );
                                }).toList(),
                                max: additiveModel.min,
                                min: additiveModel.max,
                                isAvailable: additiveModel.isAvailable,
                                id: additiveModel.id);
                          }).toList();
                          List<MealPack> mealPack =
                              controller.newPacks.map((packs) {
                            return MealPack(
                                restaurantId: packs.restaurantId,
                                packName: packs.packName,
                                packDescription: packs.packDescription,
                                price: packs.price,
                                isAvailable: packs.isAvailable,
                                id: packs.id);
                          }).toList();
                          CreateFoodModel model = CreateFoodModel(
                              title: mealName,
                              time: "1",
                              foodTags: ["unknow"],
                              categoryId: foodCategory,
                              foodType: ["unknow"],
                              code: code,
                              isAvailable: controller.isSwitched.value,
                              restaurantId: restaurantId,
                              rating: 3.0,
                              ratingCount: "276",
                              description: mealDescription,
                              price: price,
                              priceDescription: priceDescription,
                              additive: mealAdditives,
                              pack: mealPack,
                              imageUrl: [uploadController.imageOneUrl],
                              restaurantCategory: menuCategory);
                          final String data = createFoodModelToJson(model);
                          debugPrint(data);
                          debugPrint(mealAdditives[0].id);
                          controller.createMealFunction(data);
                          // priceDescription = "";
                          // String priceString =  price.toString();

                          // priceString = "";
                        } else {
                          Get.snackbar("Error while creating Meal",
                              "Try again! or reach out to the chopnow team",
                              colorText: Tcolor.Text,
                              duration: const Duration(seconds: 4),
                              backgroundColor: Tcolor.Primary,
                              icon: const Icon(Ionicons.fast_food_outline));
                        }
                      },
                      child: CustomButton(
                        title: "Add meal",
                        fontSize: 28.sp,
                        textColor: Tcolor.Text,
                        fontWeight: FontWeight.w500,
                        showArrow: false,
                        btnHeight: 80.h,
                        btnWidth: width,
                        raduis: 100.r,
                        btnColor: Tcolor.PRIMARY_Button_color_2,
                        // gradient: Tcolor.Primary_button,
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          if (controller.isLoading) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Dim background
                child: Center(
                  child: LottieBuilder.asset(
                    'assets/animation/loading_state.json', // Replace with your Lottie file path
                    width: 200.w,
                    height: 200.h,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
