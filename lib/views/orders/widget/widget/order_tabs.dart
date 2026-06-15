
import 'package:get/get.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/views/orders/widget/widget/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class OrderTabs extends StatelessWidget {
//   const OrderTabs({
//     super.key,
//     required TabController tabController,  required this.counts,
//   }) : _tabController = tabController;

//   final TabController _tabController;
//    final RxList<int> counts; // Change this to List<int>

//   @override
//   Widget build(BuildContext context) {
//     return TabBar(
//       controller: _tabController,
//       physics: const AlwaysScrollableScrollPhysics(),
//       labelPadding: EdgeInsets.zero,
//       // indicatorPadding: EdgeInsets.only(left: 50.w, right: 50.w),
//       isScrollable: true,
//       dividerColor: Colors.transparent,
//       tabAlignment: TabAlignment.start,
//       indicator: BoxDecoration(
//           borderRadius: BorderRadius.circular(50.r),
//           border: Border.all(color: Tcolor.Secondary_Base),
//           color: Tcolor.SECONDARY_T2),
//       labelColor: Tcolor.Secondary_S2,
//       labelStyle: TextStyle(
//           fontSize: 28.sp,
//           fontWeight: FontWeight.w500,
//           color: Tcolor.White),
//       unselectedLabelColor: Tcolor.TEXT_Placeholder,
//       unselectedLabelStyle: TextStyle(
//           fontSize: 28.sp,
//           fontWeight: FontWeight.w500,
//           color: Tcolor.TEXT_Placeholder),
//       tabs: List.generate(orderList.length, (i) {
//             return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.w),
//               child: TabWidget(text: "${orderList[i]} ${counts[i]}" ),
//             );
//           }),
//     );
//   }
// }

class OrderTabs extends StatelessWidget {
  const OrderTabs({
    super.key,
    required TabController tabController,
    required this.counts,
  }) : _tabController = tabController;

  final TabController _tabController;
  final RxList<int> counts; // ✅ keep it as RxList

  @override
  Widget build(BuildContext context) {
    return Obx(() => TabBar(
          controller: _tabController,
          physics: const AlwaysScrollableScrollPhysics(),
          labelPadding: EdgeInsets.zero,
          isScrollable: true,
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(color: Tcolor.Secondary_Base),
              color: Tcolor.SECONDARY_T2),
          labelColor: Tcolor.Secondary_S2,
          labelStyle: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
              color: Tcolor.White),
          unselectedLabelColor: Tcolor.TEXT_Placeholder,
          unselectedLabelStyle: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
              color: Tcolor.TEXT_Placeholder),
          tabs: List.generate(orderList.length, (i) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: TabWidget(text: "${orderList[i]} ${counts[i]}" ),
            );
          }),
        ));
  }
}
