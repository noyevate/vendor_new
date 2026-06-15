import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';

class OrderNotificationPage extends StatelessWidget {
  const OrderNotificationPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.White,
      body: ReuseableText(title: id.toString(), style: TextStyle(fontSize: 30.sp, color: Tcolor.Text, fontWeight: FontWeight.w600)),
    );
  }
}