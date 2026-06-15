// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:get/get.dart';
import 'package:vendor/common/custom_bottom_navr_bar.dart';
import 'package:vendor/empty_order_paga.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/views/profile/profile.dart';
import 'package:vendor/views/menu/menu.dart';
import 'package:vendor/views/orders/order.dart';
import 'package:vendor/views/support/support.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    this.loginModel,
  });
  final LoginResponseModel? loginModel;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Check if there is an argument passed for the selected index
    final args = Get.arguments;
    if (args != null && args is int) {
      _selectedIndex = args;
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var userId = box.read("userID");

    // Define the page list based on loading and userRestaurant status
    final List<Widget> pageList = (widget.loginModel != null &&
            widget.loginModel!.ownedRestaurant != null &&
            widget.loginModel!.ownedRestaurant!.verification == "Verified")
        ? [
            const OrderPage(), // Pass tabIndex to OrderPage
            MenuPage(restaurantProfile: widget.loginModel),
            const SupportPage(),
            ProfilePage(
              restaurantProfile: widget.loginModel,
            ),
          ]
        : [
            EmptyOrderPage(
              restaurant: widget.loginModel,
            ), // Show EmptyOrderPage if foods are empty
            MenuPage(restaurantProfile: widget.loginModel),
            const SupportPage(),
            EmptyOrderPage(
              restaurant: widget.loginModel,
            ),
          ];

    // On navigation item tap
    void _onNavItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: pageList[_selectedIndex],
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: CustomBottomNav(
            //     selectedIndex: _selectedIndex,
            //     onItemTapped: _onNavItemTapped,
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar: Stack(
          children: [
            CustomBottomNav(
              selectedIndex: _selectedIndex,
              onItemTapped: _onNavItemTapped,
            )
          ],
        ));
  }
}
