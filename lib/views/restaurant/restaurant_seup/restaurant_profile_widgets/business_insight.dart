import 'package:vendor/common/business_insight_tile.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/page_title.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BusinessInsight extends StatefulWidget {
  const BusinessInsight({super.key});

  @override
  State<BusinessInsight> createState() => _BusinessInsightState();
}

class _BusinessInsightState extends State<BusinessInsight> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: Container(
          color: Tcolor.White,
          padding: EdgeInsets.only(left: 30.w),
          child: SafeArea(
            child: Column(
              children: [
                
                const PageTitle(
                  title: "Business insight",
                ),
              ],
            ),
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return   Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
            height: 50.h,
          ),
            const BusinessInsightTile(title: 'TOTAL REVENUE', title1: 'NGN ${0}',),
            SizedBox(
            height: 20.h,
          ),
            const BusinessInsightTile(title: 'TOTAL ORDERS', title1: '${0}',),
            SizedBox(
            height: 20.h,
          ),
            const BusinessInsightTile(title: 'PREPARING ORDERS', title1: '${0}',),
            SizedBox(
            height: 20.h,
          ),
            const BusinessInsightTile(title: 'COMPLETED ORDERS', title1: '${0}',),
            SizedBox(
            height: 20.h,
          ),
            const BusinessInsightTile(title: 'REJECTED ORDERS', title1: '${0}',),
          ],
        );
      }),
    );
  }
}
