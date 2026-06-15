import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/pack_field.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/businnessInsight_controller.dart';
import 'package:vendor/models/order_model.dart';
import 'package:vendor/views/profile/widget/busines_insights/business_date_filter_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class BusinessDateFilter extends StatefulWidget {
  const BusinessDateFilter({super.key, required this.order});
  final List<OrderModel> order;

  @override
  _BusinessDateFilterState createState() => _BusinessDateFilterState();
}

class _BusinessDateFilterState extends State<BusinessDateFilter> {
  final controller = Get.put(BusinesInsightController());

  // Track selected filter
  String selectedFilter = "All time";

  bool showCustomDateFields =
      false; // Tracks whether custom date fields are visible

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 40.w, top: 30.sp),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReuseableText(
                      title: "Date filter",
                      style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: Tcolor.Text),
                    ),
                    Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: Tcolor.BACKGROUND_Dark,
                        borderRadius: BorderRadius.circular(60.r),
                      ),
                      child: Center(
                        child: IconButton(
                          splashColor: Tcolor.BACKGROUND_Regaular,
                          onPressed: () => Get.back(),
                          icon: Icon(
                            HeroiconsOutline.xMark,
                            color: Tcolor.Text,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = "All time";
                          controller.showCustomDateFields.value = false;
                        });
                      },
                      child: BusinessDateFilterContainer(
                        selectedFilter: selectedFilter,
                        color1: selectedFilter == "All time"
                            ? Tcolor.SECONDARY_T2
                            : Tcolor.White,
                        title: "All time",
                        color2: selectedFilter == "All time"
                            ? Tcolor.SECONDARY_Button
                            : Tcolor.BORDER_Light,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = "Current week";
                          controller.showCustomDateFields.value = false;
                        });
                      },
                      child: BusinessDateFilterContainer(
                        selectedFilter: selectedFilter,
                        color1: selectedFilter == "Current week"
                            ? Tcolor.SECONDARY_T2
                            : Tcolor.White,
                        title: "Current week",
                        color2: selectedFilter == "Current week"
                            ? Tcolor.SECONDARY_Button
                            : Tcolor.BORDER_Light,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = "Last week";
                          controller.showCustomDateFields.value = false;
                        });
                      },
                      child: BusinessDateFilterContainer(
                        selectedFilter: selectedFilter,
                        color1: selectedFilter == "Last week"
                            ? Tcolor.SECONDARY_T2
                            : Tcolor.White,
                        title: "Last week",
                        color2: selectedFilter == "Last week"
                            ? Tcolor.SECONDARY_Button
                            : Tcolor.BORDER_Light,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = "Current month";
                          controller.showCustomDateFields.value = false;
                        });
                      },
                      child: BusinessDateFilterContainer(
                        selectedFilter: selectedFilter,
                        color1: selectedFilter == "Current month"
                            ? Tcolor.SECONDARY_T2
                            : Tcolor.White,
                        title: "Current month",
                        color2: selectedFilter == "Current month"
                            ? Tcolor.SECONDARY_Button
                            : Tcolor.BORDER_Light,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = "Last month";
                          controller.showCustomDateFields.value = false;
                        });
                      },
                      child: BusinessDateFilterContainer(
                        selectedFilter: selectedFilter,
                        color1: selectedFilter == "Last month"
                            ? Tcolor.SECONDARY_T2
                            : Tcolor.White,
                        title: "Last month",
                        color2: selectedFilter == "Last month"
                            ? Tcolor.SECONDARY_Button
                            : Tcolor.BORDER_Light,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = "Current year";
                          controller.showCustomDateFields.value = false;
                        });
                      },
                      child: BusinessDateFilterContainer(
                        selectedFilter: selectedFilter,
                        color1: selectedFilter == "Current year"
                            ? Tcolor.SECONDARY_T2
                            : Tcolor.White,
                        title: "Current year",
                        color2: selectedFilter == "Current year"
                            ? Tcolor.SECONDARY_Button
                            : Tcolor.BORDER_Light,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = "Last year";
                          controller.showCustomDateFields.value = false;
                        });
                      },
                      child: BusinessDateFilterContainer(
                        selectedFilter: selectedFilter,
                        color1: selectedFilter == "Last year"
                            ? Tcolor.SECONDARY_T2
                            : Tcolor.White,
                        title: "Last year",
                        color2: selectedFilter == "Last year"
                            ? Tcolor.SECONDARY_Button
                            : Tcolor.BORDER_Light,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          setState(() {
                            selectedFilter = "Custom";
                            controller.showCustomDateFields.value = true;
                          });
                        });
                      },
                      child: BusinessDateFilterContainer(
                        selectedFilter: selectedFilter,
                        color1: selectedFilter == "Custom"
                            ? Tcolor.SECONDARY_T2
                            : Tcolor.White,
                        title: "Custom range",
                        color2: selectedFilter == "Custom"
                            ? Tcolor.SECONDARY_Button
                            : Tcolor.BORDER_Light,
                      ),
                    ),
                    BusinessDateFilterContainer(
                        selectedFilter: selectedFilter,
                        color1: Tcolor.White,
                        title: "",
                        color2: Tcolor.White),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(() {
                  return controller.showCustomDateFields.value
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                              title: "Custom range",
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Tcolor.Text),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReuseableText(
                                      title: "Start date",
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Tcolor.TEXT_Label),
                                    ),
                                    PackField(
                                      controller:
                                          controller.startDateController,
                                      width1: 300.w,
                                      hintText: "(YYYY-MM-DD)",
                                      suffixIcon: Icon(
                                        HeroiconsOutline.calendar,
                                        size: 40.sp,
                                        color: Tcolor.TEXT_Label,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 50.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReuseableText(
                                      title: "End date",
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Tcolor.TEXT_Label),
                                    ),
                                    PackField(
                                      suffixIcon: Icon(
                                        HeroiconsOutline.calendar,
                                        size: 40.sp,
                                        color: Tcolor.TEXT_Label,
                                      ),
                                      controller: controller.endDateController,
                                      width1: 300.w,
                                      hintText: "(YYYY-MM-DD)",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(); // Empty container when not showing custom fields
                }),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  controller.startDateController.text = "";
                  controller.endDateController.text = "";
                },
                child: CustomButton(
                  title: "Reset filter",
                  showArrow: false,
                  btnWidth: 290.w,
                  btnHeight: 90.h,
                  btnColor: Tcolor.White,
                  raduis: 50.r,
                  border: Border.all(color: Tcolor.BORDER_Regular),
                  textColor: Tcolor.Text,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500,
                  onTap: () {},
                ),
              ),
              CustomButton(
                title: "Apply filter",
                showArrow: false,
                btnWidth: 290.w,
                btnHeight: 90.h,
                raduis: 50.r,
                btnColor: Tcolor.PRIMARY_Button_color_2,
                textColor: Tcolor.Text,
                fontSize: 32.sp,
                fontWeight: FontWeight.w500,
                onTap: () {
                  switch (selectedFilter) {
                    case "Current week":
                      List<OrderModel> currentWeek =
                          controller.getWeeklyOrders(widget.order);
                      controller.updateInsightData(currentWeek, "Current week");
                      break;

                    case "Last week":
                      List<OrderModel> lastWeek =
                          controller.getLastWeekOrders(widget.order);
                      controller.updateInsightData(lastWeek, "Last week");
                      break;

                    case "All time":
                      controller.updateInsightData(widget.order, "All time");
                      break;

                    case "Current month":
                      List<OrderModel> currentMonth =
                          controller.getCurrentMonthOrders(widget.order);
                      controller.updateInsightData(
                          currentMonth, "Current month");
                      break;

                    case "Last month":
                      List<OrderModel> lastMonth =
                          controller.getLastMonthOrders(widget.order);
                      controller.updateInsightData(lastMonth, "Last month");
                      break;

                    case "Current year":
                      List<OrderModel> currentYear =
                          controller.getCurrentYearOrders(widget.order);
                      controller.updateInsightData(currentYear, "Current year");
                      break;

                    case "Last year":
                      List<OrderModel> lastYear =
                          controller.getLastYearOrders(widget.order);
                      controller.updateInsightData(lastYear, "Custom filter");
                      break;

                    case "Custom":
                      // print("yeah");

                      controller.applyCustomDateFilter(
                        widget.order,
                      );

                      break;

                    default:
                      controller.updateInsightData(widget.order, "All time");
                      break;
                  }

                  Get.back();
                },
              ),
            ],
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
