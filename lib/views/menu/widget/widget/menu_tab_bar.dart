
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/views/menu/widget/widget/menu_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuTabBar extends StatelessWidget {
  const MenuTabBar({
    super.key,
    required TabController tabController
  }) : _tabController = tabController;

  final TabController _tabController;
   

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      physics: const AlwaysScrollableScrollPhysics(),
      labelPadding: EdgeInsets.zero,
      // indicatorPadding: EdgeInsets.only(left: 50.w, right: 50.w),
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
      tabs: List.generate(menuList.length, (i) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: MenuTabWidget(text: "${menuList[i]}" ),
            );
          }),
    );
  }
}