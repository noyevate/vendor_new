import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/login_controller.dart';
import 'package:vendor/controller/password_controller.dart';
import 'package:vendor/models/login_input_model.dart';
import 'package:vendor/views/auth/create_account/create_account_page.dart';
import 'package:vendor/views/auth/login/widget/email_textfield.dart';
import 'package:vendor/views/auth/login/widget/password_textField.dart';
import 'package:vendor/views/auth/reset_pin/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_onTextChanged);
    _passwordController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.removeListener(_onTextChanged);
    _passwordController.removeListener(_onTextChanged);

    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordContrroller = Get.put(PasswordController());
    final controller = Get.put(LoginController(), permanent: true);

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Column(
                    children: [
                      if (GetStorage().read('firstLaunch') == true)
                        const PageTitle(),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              height: height,
              width: width,
              color: Tcolor.White,
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30.h),
                          ReuseableText(
                            title: "Login",
                            style: TextStyle(
                              color: Tcolor.Text,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w700,
                              wordSpacing: 2.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          ReuseableText(
                            title:
                                "Let’s get you back right into your account.",
                            style: TextStyle(
                              color: Tcolor.TEXT_Label,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 90.h),
                          ReuseableText(
                            title: "Email",
                            style: TextStyle(
                              color: Tcolor.TEXT_Label,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: 96.h,
                            child: EmailTextField(
                              hintText: "e.g Adewalejohn2example.com",
                              prefixIcon: Icon(
                                HeroiconsOutline.envelope,
                                size: 28.sp,
                              ),
                              controller: _emailController,
                            ),
                          ),
                          SizedBox(height: 30.h),
                          ReuseableText(
                            title: "Password",
                            style: TextStyle(
                              color: Tcolor.TEXT_Label,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: 96.h,
                            child: PasswordTextField(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  passwordContrroller.setPassword =
                                      !passwordContrroller.password;
                                },
                                child: passwordContrroller.password
                                    ? Icon(
                                        HeroiconsOutline.eye,
                                        size: 28.sp,
                                      )
                                    : Icon(
                                        HeroiconsOutline.eyeSlash,
                                        size: 26.sp,
                                      ),
                              ),
                              prefixIcon: Icon(
                                HeroiconsOutline.lockClosed,
                                size: 28.sp,
                              ),
                              controller: _passwordController,
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const ResetPassword(),
                                      transition: Transition.fadeIn,
                                      duration:
                                          const Duration(milliseconds: 800));
                                },
                                child: ReuseableText(
                                  title: "Forgot Password?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 32.sp,
                                    color: Tcolor.PRIMARY_S4,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const CreateAccount());
                                },
                                child: ReuseableText(
                                  title: "New User ? ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 32.sp,
                                    color: Tcolor.PRIMARY_S4,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    title: "Login",
                    textColor: _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty
                        ? Tcolor.Text
                        : Tcolor.TEXT_Label,
                    btnColor: _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty
                        ? Tcolor.PRIMARY_Button_color_2
                        : Tcolor.PRIMARY_T4,
                    btnWidth: MediaQuery.of(context).size.width / 1.1,
                    btnHeight: 96.h,
                    raduis: 100.r,
                    fontSize: 32.sp,
                    showArrow: false,
                    onTap: _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty
                        ? () async {
                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              LoginInputModel model = LoginInputModel(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              final data = loginInputModelToJson(model);
                              await controller.login(data);
                            } else {
                              Get.snackbar(
                                'Ensure you fill the fields...',
                                '',
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                borderRadius: 8,
                                colorText: Tcolor.PRIMARY_S4,
                                barBlur: 10,
                                duration: const Duration(seconds: 20),
                              );
                            }
                          }
                        : () {
                            Fluttertoast.showToast(msg: "fields empty");
                          },
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),

        // Full-Screen Loading Overlay
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
