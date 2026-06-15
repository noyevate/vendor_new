import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/reusable_text_widget.dart';

class PinEntryDialog extends StatefulWidget {
  const PinEntryDialog({
    super.key,
    required this.onSubmit,
  });

  // A callback function to submit the entered PIN
  final Future<void> Function(String pin) onSubmit;

  @override
  State<PinEntryDialog> createState() => _PinEntryDialogState();
}

class _PinEntryDialogState extends State<PinEntryDialog> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: ReuseableText(
        title: "Confirm Delivery",
        style: TextStyle(
            fontSize: 25.sp, fontWeight: FontWeight.bold, color: Tcolor.Text),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Please enter the 4-digit PIN from the customer to complete the delivery.",
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Tcolor.Text_Secondary),
          ),
          SizedBox(height: 24.h),
          // Using the 'pinput' package for a nice PIN field UI
          Pinput(
            length: 4,
            controller: _pinController,
            focusNode: _pinFocusNode,
            keyboardType: TextInputType.number,
            defaultPinTheme: PinTheme(
              width: 56,
              height: 56,
              textStyle: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: Tcolor.Text),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            focusedPinTheme: PinTheme(
              textStyle: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Tcolor.Text),
              decoration: BoxDecoration(
                border: Border.all(color: Tcolor.Primary),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Get.back(),
          child: const Text("Cancel"),
        ),
        CustomButton(
          title: _isLoading ? "Verifying..." : "Confirm for Pickup",
          showArrow: false,
          fontSize: 25.sp,
          fontWeight: FontWeight.bold,
          onTap: _isLoading
              ? null
              : () async {
                  if (_pinController.text.length == 4) {
                    setState(() {
                      _isLoading = true;
                    });
                    // Call the async submit function passed from the UI
                    await widget.onSubmit(_pinController.text);
                    // The controller will handle navigation/errors, but we can stop loading
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
        ),
      ],
    );
  }
}
