import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum IconType { svg, image }

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    this.color,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final Color? color;
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
      ),
      child: Container(
        height: 110.h,
        decoration: BoxDecoration(
          color: Tcolor.White1,
          border: Border.all(color: Tcolor.BACKGROUND_Dark),
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
        ),
        // padding: EdgeInsets.symmetric( vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem(
              context,
              iconData: HeroiconsOutline.shoppingBag,
              iconData2: HeroiconsMini.shoppingBag,
              label: 'Order',
              index: 0,
              onPressed: () => onItemTapped(0),
            ),
            _buildNavItem(
              context,
              iconPath: "assets/img/inactive_menu.png",
              iconPath2: "assets/img/active_menu.png",
              iconType: IconType.image,
              label: 'Menu',
              index: 1,
              onPressed: () => onItemTapped(1),
            ),
            _buildNavItem(
              context,
              iconPath: "assets/img/inactive_support.png",
              iconPath2: "assets/img/active_support.png",
              iconType: IconType.image,
              label: 'Support',
              index: 2,
              onPressed: () => onItemTapped(2),
            ),
            _buildNavItem(
              context,
              iconData: HeroiconsOutline.buildingStorefront,
              iconData2: HeroiconsMini.buildingStorefront,
              label: 'Profile',
              index: 3,
              onPressed: () => onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    String? iconPath,
    String? iconPath2,
    IconData? iconData,
    IconData? iconData2,
    required String label,
    IconType? iconType,
    required int index,
    required VoidCallback onPressed,
  }) {
    assert(iconPath != null || iconData != null || iconPath2 != null || iconPath2 != null,
        'Either iconPath or iconData must be provided');
    assert(iconType != null || iconData != null,
        'iconType must be provided if using iconPath');

    bool isSelected = selectedIndex == index;
    Color itemColor = isSelected ? Tcolor.Secondary_Base : Tcolor.TEXT_Label;

    Widget iconWidget;
    if (iconPath != null  && iconType != null && iconPath2 != null) {
      switch (iconType) {
        case IconType.svg:
          iconWidget = SvgPicture.asset(
            isSelected ? iconPath2 : iconPath,
            width: 35.w,
            height: 35.h,
            colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
          );
          break;
        case IconType.image:
          iconWidget = Image.asset(
            isSelected ? iconPath2 : iconPath,
            width: 35.w,
            height: 35.h,
            // color: Colors.redAccent,
          );
          break;
      }
    } else {
      iconWidget = Icon(
        isSelected ? iconData2 : iconData,
        color: itemColor,
        size: 30.sp,
      );
    }

    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 105.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.w,
              height: 30.h,
              child: FittedBox(
                fit: BoxFit.contain,
                child: iconWidget,
              ),
            ),
            if (isSelected)
              Container(
                margin: EdgeInsets.only(
                    top: 20.h), // Adds spacing between icon and dot
                width: 10.w,
                height: 10.h,
                decoration: BoxDecoration(
                  color: Tcolor.Secondary_Base,
                  shape: BoxShape.circle,
                ),
              ),
            if (!isSelected)
              Padding(
                padding: EdgeInsets.only(
                    top: 4.h), // Adds spacing between icon and label
                child: ReuseableText(
                  title: label,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: itemColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
