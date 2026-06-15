import 'package:get_storage/get_storage.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/views/auth/login/login_page.dart';
import 'package:vendor/views/onboarding/walk_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    route();
  }

  void route() {
    final firstLaunch = GetStorage().read('firstLaunch') ?? true;
    debugPrint("firstLaunch value: $firstLaunch");

    Future.delayed(const Duration(seconds: 3), () {
      if (firstLaunch) {
        GetStorage().write('firstLaunch', false);

        Get.off(
          () => const WalkThrough(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 700),
        );
      } else {
        Get.offAll(
          () => const LoginPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 700),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.Primary_New,
      body: Center(
        child: Container(
          height: 150.h,
          width: 150.w,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(100.r)
          ),
          child: Center(
              child: Image.asset(
            "assets/img/app_icon.png",
            height: 100.h,
            width: 200.w,
          )),
        ),
      ),
    );
  }
}
