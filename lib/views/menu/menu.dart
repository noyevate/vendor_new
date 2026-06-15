import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/create_dditive_controller.dart';
import 'package:vendor/controller/order_controller.dart';
import 'package:vendor/controller/pack_controller.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/views/menu/widget/additive.dart';
import 'package:vendor/views/menu/widget/meals.dart';
import 'package:vendor/views/menu/widget/packs.dart';
import 'package:vendor/views/menu/widget/widget/AdditiveWiget/create_additive.dart';
import 'package:vendor/views/menu/widget/widget/PackWidget/create_packs.dart';
import 'package:vendor/views/menu/widget/widget/add_meal.dart';
import 'package:vendor/views/menu/widget/widget/menu_tab_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, this.selectedIndex, this.restaurantProfile});

  final int? selectedIndex;
  final LoginResponseModel? restaurantProfile;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final controller = Get.put(PackController());
  final additiveController = Get.put(AdditiveController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: menuList.length, vsync: this);

    if (widget.selectedIndex != null) {
      // Set initial tab index if provided
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tabController.animateTo(widget.selectedIndex!);
      });
    }

    final controller = Get.put(OrderController());
    controller.setTabController(_tabController);

    _tabController.addListener(() {
      setState(() {}); // triggers rebuild when switching tabs
    });
  }

  Widget? getFloatingActionButton() {
    switch (_tabController.index) {
      case 0: // MealsPage
        return FloatingActionButton(
          backgroundColor: const Color.fromRGBO(255, 184, 0, 1),
          shape: const CircleBorder(),
          onPressed: widget.restaurantProfile?.ownedRestaurant != null
              ? () {
                  debugPrint(
                      "jsdkj:  ${widget.restaurantProfile?.ownedRestaurant!.restaurantFcm}");
                  Get.to(
                      () => AddMealWidget(restaurant: widget.restaurantProfile),
                      transition: Transition.fadeIn);
                  print(widget.restaurantProfile?.ownedRestaurant?.id);
                }
              : () {
                  debugPrint(
                      "jsdkj:  ${widget.restaurantProfile?.ownedRestaurant}");
                  Get.rawSnackbar(
                    message: "Restaurant not available",
                    backgroundColor: Colors.grey[800]!,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.only(
                      bottom: 20, // distance from bottom
                      left: MediaQuery.of(context).size.width * 0.18,
                      right: MediaQuery.of(context).size.width * 0.25,
                    ),
                    borderRadius: 20,
                    duration: const Duration(seconds: 3),
                    animationDuration: const Duration(milliseconds: 300),
                    isDismissible: true,
                  );
                },
          child: Icon(
            HeroiconsOutline.plus,
            color: Tcolor.Text,
            size: 32.sp,
          ),
        );
      case 1: // AdditivePage
        return FloatingActionButton(
          backgroundColor: Tcolor.PRIMARY_Button_color_2,
          shape: const CircleBorder(),
          onPressed: widget.restaurantProfile?.ownedRestaurant != null
              ? () {
                  Get.to(
                      () => CreateAdditive(refetch: additiveController.refetch),
                      transition: Transition.fadeIn);
                }
              : () {
                  Get.rawSnackbar(
                    message: "Restaurant not available",
                    backgroundColor: Colors.grey[800]!,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.only(
                      bottom: 20, // distance from bottom
                      left: MediaQuery.of(context).size.width * 0.18,
                      right: MediaQuery.of(context).size.width * 0.25,
                    ),
                    borderRadius: 20,
                    duration: const Duration(seconds: 3),
                    animationDuration: const Duration(milliseconds: 300),
                    isDismissible: true,
                  );
                },
          child: Icon(
            HeroiconsOutline.plus,
            color: Tcolor.Text,
            size: 32.sp,
          ),
        );
      case 2: // PacksPage
        return FloatingActionButton(
          backgroundColor: Tcolor.PRIMARY_Button_color_2,
          shape: const CircleBorder(),
          onPressed: widget.restaurantProfile?.ownedRestaurant != null
              ? () {
                  Get.to(() => CreatePack(refetch: controller.refetch),
                      transition: Transition.fadeIn);
                  print("Packs");
                }
              : () {
                  Get.rawSnackbar(
                    message: "Restaurant not available",
                    backgroundColor: Colors.grey[800]!,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.only(
                      bottom: 20, // distance from bottom
                      left: MediaQuery.of(context).size.width * 0.18,
                      right: MediaQuery.of(context).size.width * 0.25,
                    ),
                    borderRadius: 20,
                    duration: const Duration(seconds: 3),
                    animationDuration: const Duration(milliseconds: 300),
                    isDismissible: true,
                  );
                },
          child: Icon(
            HeroiconsOutline.plus,
            color: Tcolor.Text,
            size: 32.sp,
          ),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdditiveController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(220.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return controller.showSdditiveOutOfStock.value
                  ? Container(
                      color: Tcolor.SUCCESS_Light_2,
                      width: double.infinity,
                      height: 100.h,
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                        child: Row(
                          children: [
                            Icon(
                              HeroiconsSolid.checkCircle,
                              color: Tcolor.SUCCESS_Reg,
                              size: 32.sp,
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReuseableText(
                                    title: "Additive availability changed",
                                    style: TextStyle(
                                        color: Tcolor.SUCCESS_Reg,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        controller.showSdditiveOutOfStock
                                            .value = false;
                                      },
                                      child: Icon(
                                        HeroiconsOutline.xMark,
                                        color: Tcolor.TEXT_Placeholder,
                                        size: 40.sp,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                  : SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.w, top: 50.h),
                        child: ReuseableText(
                          title: "Menu",
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: Tcolor.Text,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ); // Empty widget if not shown
            }),
            Container(
              padding: EdgeInsets.only(left: 30.w),
              decoration: BoxDecoration(color: Tcolor.White),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  MenuTabBar(
                    tabController: _tabController,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Tcolor.BACKGROUND_Regaular,
        child: TabBarView(controller: _tabController, children: [
          MealsPage(
            restaurantProfile: widget.restaurantProfile,
          ),
          const AdditivePage(),
          const PacksPage()
        ]),
      ),
      floatingActionButton: getFloatingActionButton(),
    );
  }
}
