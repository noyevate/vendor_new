import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/setup_field.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/operating_hours_controller.dart';
import 'package:vendor/controller/operating_hours_controller_new.dart';
import 'package:vendor/enty_point.dart';
import 'package:vendor/models/add_time_model.dart';
import 'package:vendor/models/fetch_user_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/models/loging_response_model.dart';

// class OperatingHours extends StatefulWidget {
//   const OperatingHours({super.key, this.restaurant});
//   final LoginResponseModel? restaurant;

//   @override
//   State<OperatingHours> createState() => _OperatingHoursState();
// }

// class _OperatingHoursState extends State<OperatingHours> {
//   @override
//   Widget build(BuildContext context) {
//     final box = GetStorage();
//     var restaurantId = box.read("restaurantId");
//     restaurantId ??=
//         widget.restaurant?.id ?? widget.restaurant?.ownedRestaurant?.id;

//     final OperatingHoursController controller =
//         Get.put(OperatingHoursController());

//     return Stack(
//       children: [
//         Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(80.h),
//             child: Padding(
//               padding: EdgeInsets.only(left: 30.w),
//               child: SafeArea(
//                 child: Column(
//                   children: const [
//                     PageTitle(title: "Operating hours"),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           body: LayoutBuilder(
//             builder: (context, constraints) {
//               return Container(
//                 color: Tcolor.White,
//                 height: constraints.maxHeight,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         padding: EdgeInsets.only(left: 30.w, right: 30.w),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 50.h),
//                             ReuseableText(
//                               title: "Order type",
//                               style: TextStyle(
//                                 color: Tcolor.TEXT_Label,
//                                 fontSize: 28.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(height: 10.h),
//                             Obx(() {
//                               return GestureDetector(
//                                 child: SetupField(
//                                   sufixIcon: GestureDetector(
//                                     onTap: () {
//                                       controller.showOrderTypeOptions(context);
//                                     },
//                                     child: Icon(
//                                       HeroiconsOutline.chevronDown,
//                                       size: 28.sp,
//                                       color: Tcolor.TEXT_Label,
//                                     ),
//                                   ),
//                                   controller: TextEditingController(
//                                       text: controller.orderType.value),
//                                   hintText: "choose a preferred option",
//                                   onChanged: (value) {
//                                     controller.orderType.value = value;
//                                     controller.validateForm();
//                                   },
//                                   onTap: () {
//                                     controller.showOrderTypeOptions(context);
//                                   },
//                                 ),
//                               );
//                             }),
//                             SizedBox(height: 40.h),
//                             Obx(() {
//                               if (controller.orderType.value == "Pre-order") {
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     ReuseableText(
//                                       title: "Order cut-off time",
//                                       style: TextStyle(
//                                         color: Tcolor.TEXT_Label,
//                                         fontSize: 28.sp,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     SizedBox(height: 10.h),
//                                     SetupField(
//                                       sufixIcon: Icon(
//                                         HeroiconsOutline.chevronDown,
//                                         size: 28.sp,
//                                         color: Tcolor.TEXT_Label,
//                                       ),
//                                       onTap: () {
//                                         controller.showTimePickerSheet(context,
//                                             (selectedTime) {
//                                           controller.orderCutOff.value =
//                                               selectedTime;
//                                           controller.validateForm();
//                                         });
//                                       },
//                                       controller: TextEditingController(
//                                           text: controller.orderCutOff.value),
//                                       onChanged: (value) {
//                                         controller.orderCutOff.value = value;
//                                         controller.validateForm();
//                                       },
//                                       keyboardType: TextInputType.emailAddress,
//                                     ),
//                                     ReuseableText(
//                                       title:
//                                           "This is the time you no longer receive orders for the day",
//                                       style: TextStyle(
//                                         color: Tcolor.TEXT_Label,
//                                         fontSize: 24.sp,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                     SizedBox(height: 40.h),
//                                   ],
//                                 );
//                               } else {
//                                 return const SizedBox.shrink();
//                               }
//                             }),
//                             SizedBox(height: 10.h),
//                             Obx(() {
//                               if (controller.orderType.value == "Pre-order") {
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     ReuseableText(
//                                       title: "Menu ready time",
//                                       style: TextStyle(
//                                         color: Tcolor.TEXT_Label,
//                                         fontSize: 28.sp,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     SizedBox(height: 10.h),
//                                     SetupField(
//                                       sufixIcon: Icon(
//                                         HeroiconsOutline.chevronDown,
//                                         size: 28.sp,
//                                         color: Tcolor.TEXT_Label,
//                                       ),
//                                       onTap: () {
//                                         controller.showTimePickerSheet(context,
//                                             (selectedTime) {
//                                           controller.menuReadyTime.value =
//                                               selectedTime;
//                                           controller.validateForm();
//                                         });
//                                       },
//                                       controller: TextEditingController(
//                                           text: controller.menuReadyTime.value),
//                                       // hintText: "e.g restaurant@example.com",
//                                       onChanged: (value) {
//                                         controller.menuReadyTime.value = value;
//                                         controller.validateForm();
//                                       },
//                                       keyboardType: TextInputType.emailAddress,
//                                     ),
//                                     ReuseableText(
//                                       title:
//                                           "This is the time when the first order is ready for delivery",
//                                       style: TextStyle(
//                                         color: Tcolor.TEXT_Label,
//                                         fontSize: 24.sp,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                     SizedBox(height: 40.h),
//                                   ],
//                                 );
//                               } else {
//                                 return const SizedBox.shrink();
//                               }
//                             }),
//                             ReuseableText(
//                               title: "Day",
//                               style: TextStyle(
//                                 color: Tcolor.TEXT_Label,
//                                 fontSize: 28.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(height: 10.h),
//                             SetupField(
//                               contentPadding:
//                                   EdgeInsets.only(left: 10.w, bottom: 50.h),
//                               controller: TextEditingController(
//                                   text: controller.day.value),
//                               onChanged: (value) {
//                                 controller.day.value = value;
//                                 controller.validateForm();
//                               },
//                             ),
//                             SizedBox(height: 40.h),
//                             Obx(() {
//                               return Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       ReuseableText(
//                                         title: "Open",
//                                         style: TextStyle(
//                                           color: Tcolor.TEXT_Label,
//                                           fontSize: 28.sp,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 10.h,
//                                       ),
//                                       SetupField(
//                                         width: 300.w,
//                                         contentPadding: EdgeInsets.only(
//                                             left: 10.w, bottom: 50.h),
//                                         onTap: () {
//                                           controller.showTimePickerSheet(
//                                               context, (selectedTime) {
//                                             controller.open.value =
//                                                 selectedTime;
//                                             controller.validateForm();
//                                           });
//                                         },
//                                         controller: TextEditingController(
//                                             text: controller.open.value),
//                                         hintText: "9am",
//                                         onChanged: (value) {
//                                           controller.open.value = value;
//                                           controller.validateForm();
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       ReuseableText(
//                                         title: "Close",
//                                         style: TextStyle(
//                                           color: Tcolor.TEXT_Label,
//                                           fontSize: 28.sp,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 10.h,
//                                       ),
//                                       SetupField(
//                                         width: 300.w,
//                                         contentPadding: EdgeInsets.only(
//                                             left: 10.w, bottom: 50.h),
//                                         onTap: () {
//                                           controller.showTimePickerSheet(
//                                               context, (selectedTime) {
//                                             controller.close.value =
//                                                 selectedTime;
//                                             controller.validateForm();
//                                           });
//                                         },
//                                         controller: TextEditingController(
//                                             text: controller.close.value),
//                                         hintText: "9pm",
//                                         onChanged: (value) {
//                                           controller.close.value = value;
//                                           controller.validateForm();
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               );
//                             }),
//                             SizedBox(height: 200.h),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: 30.w, right: 30.w, bottom: 20.h),
//                       child: GestureDetector(
//                         onTap: () async {
//                           print(restaurantId);
//                           var orderType1 = controller.orderType.value;
//                           var day1 = controller.day.value;
//                           var open1 = controller.open.value;
//                           var close1 = controller.close.value;
//                           var menuReadyTime1 = controller.menuReadyTime.value;
//                           var orderCutOffTime1 = controller.orderCutOff.value;

//                           if (controller.orderType.value == "Pre-order") {
//                             if (day1.isNotEmpty &&
//                                 open1.isNotEmpty &&
//                                 close1.isNotEmpty &&
//                                 menuReadyTime1.isNotEmpty &&
//                                 orderCutOffTime1.isNotEmpty) {
//                               final AddTimeModel model = AddTimeModel(
//                                   orderType: orderType1,
//                                   day: day1,
//                                   open: open1,
//                                   close: close1,
//                                   menuReadyTime: menuReadyTime1,
//                                   orderCutOffTime: orderCutOffTime1);
//                               String data = addTimeModelToJson(model);
//                               print(model);
//                               int? statusCode = await controller
//                                   .addOperaingHours(restaurantId, data);

//                               print("data: $data");
//                               if (statusCode == 200) {
//                                 print("200");
//                                 Get.close(1);

//                                 Get.back();
//                               } else {}
//                             } else {
//                               Get.snackbar(
//                                 "",
//                                 "",
//                                 duration: const Duration(seconds: 3),
//                                 backgroundColor: Tcolor.BACKGROUND_Regaular,
//                                 titleText: ReuseableText(
//                                   title: "Success",
//                                   style: TextStyle(
//                                       fontSize: 28.sp,
//                                       color: Tcolor.Text,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 messageText: ReuseableText(
//                                   title: "complet the neccessary fields",
//                                   style: TextStyle(
//                                       fontSize: 20.sp,
//                                       color: Tcolor.ERROR_Light_2,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               );
//                             }
//                           } else if (controller.orderType.value ==
//                               "Instant delivery") {
//                             menuReadyTime1 = "";
//                             orderCutOffTime1 = "";
//                             if (day1.isNotEmpty &&
//                                 open1.isNotEmpty &&
//                                 close1.isNotEmpty) {
//                               final AddTimeModel model = AddTimeModel(
//                                   orderType: orderType1,
//                                   day: day1,
//                                   open: open1,
//                                   close: close1);
//                               String data = addTimeModelToJson(model);
//                               int? statusCode = await controller
//                                   .addOperaingHours(restaurantId, data);
//                               if (statusCode == 200) {
//                                 print("Instant 200");
//                                 try {
//                                   Get.back();
//                                 } catch (e) {
//                                   print("Error closing: $e");
//                                 }
//                               } else {}
//                             } else {
//                               Get.snackbar(
//                                 "",
//                                 "",
//                                 duration: const Duration(seconds: 3),
//                                 backgroundColor: Tcolor.BACKGROUND_Regaular,
//                                 titleText: ReuseableText(
//                                   title: "Success",
//                                   style: TextStyle(
//                                       fontSize: 28.sp,
//                                       color: Tcolor.Text,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 messageText: ReuseableText(
//                                   title: "complete the neccessary fields",
//                                   style: TextStyle(
//                                       fontSize: 20.sp,
//                                       color: Tcolor.ERROR_Light_2,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               );
//                             }
//                           }
//                         },
//                         child: CustomButton(
//                           title: "Save changes",
//                           textColor: Tcolor.Text,
//                           btnColor: Tcolor.PRIMARY_Button_color_2,
//                           btnWidth: width,
//                           btnHeight: 96.h,
//                           raduis: 100.r,
//                           fontSize: 32.sp,
//                           showArrow: false,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         Obx(() {
//           if (controller.isLoading) {
//             return Positioned.fill(
//               child: Container(
//                 color: Colors.black.withOpacity(0.5), // Dim background
//                 child: Center(
//                   child: LottieBuilder.asset(
//                     'assets/animation/loading_state.json', // Replace with your Lottie file path
//                     width: 200.w,
//                     height: 200.h,
//                   ),
//                 ),
//               ),
//             );
//           }
//           return const SizedBox.shrink();
//         }),
//       ],
//     );
//   }
// }

class OperatingHours extends StatefulWidget {
  const OperatingHours({super.key, this.restaurant});
  final LoginResponseModel? restaurant;

  @override
  State<OperatingHours> createState() => _OperatingHoursState();
}

class _OperatingHoursState extends State<OperatingHours> {
  late final OperatingHoursControllerNew controller;
  late final String? restaurantId;

  final List<String> _displayDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final List<String> _dayKeys = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.put(OperatingHoursControllerNew());
    final box = GetStorage();
    restaurantId = box.read("restaurantId") ??
        widget.restaurant?.id ??
        widget.restaurant?.ownedRestaurant?.id;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: SafeArea(
                child: Column(
                  children: const [PageTitle(title: "Operating hours")],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              // --- Order type tabs ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
                child: Obx(() => Row(
                      children: [
                        _TabChip(
                          label: "Delivery",
                          selected: controller.selectedTab.value == 0,
                          onTap: () => controller.selectedTab.value = 0,
                        ),
                        SizedBox(width: 12.w),
                        _TabChip(
                          label: "Pickup",
                          selected: controller.selectedTab.value == 1,
                          onTap: () => controller.selectedTab.value = 1,
                        ),
                      ],
                    )),
              ),

              // --- "Same as delivery" toggle — only on pickup tab ---
              Obx(() {
                if (controller.selectedTab.value == 1) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Same hours as delivery",
                          style: TextStyle(
                            fontSize: 26.sp,
                            color: Tcolor.TEXT_Label,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Obx(() => Switch(
                              value: controller.sameHoursForBoth.value,
                              onChanged: (val) {
                                controller.sameHoursForBoth.value = val;
                              },
                              activeColor: Tcolor.PRIMARY_Button_color_2,
                            )),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),

              SizedBox(height: 16.h),

              // --- Day schedule list ---
              Expanded(
                child: Obx(() {
                  // If on pickup tab with same hours, show delivery schedule (read-only)
                  final isReadOnly = controller.selectedTab.value == 1 &&
                      controller.sameHoursForBoth.value;

                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    itemCount: _displayDays.length,
                    separatorBuilder: (_, __) => SizedBox(height: 20.h),
                    itemBuilder: (context, index) {
                      final dayKey = _dayKeys[index];
                      final dayLabel = _displayDays[index];
                      final schedule = controller.activeSchedule[dayKey]!;

                      return Obx(() => _DayRow(
                            dayLabel: dayLabel,
                            dayKey: dayKey,
                            isOpen: schedule.isOpen.value,
                            openTime: schedule.openTime.value,
                            closeTime: schedule.closeTime.value,
                            isReadOnly: isReadOnly,
                            onToggle: (val) =>
                                controller.toggleDay(dayKey, val),
                            onPickOpen: () =>
                                controller.pickTime(context, dayKey, true),
                            onPickClose: () =>
                                controller.pickTime(context, dayKey, false),
                          ));
                    },
                  );
                }),
              ),

              // --- Save button ---
              Padding(
                padding: EdgeInsets.only(
                    left: 30.w, right: 30.w, bottom: 20.h, top: 12.h),
                child: GestureDetector(
                  onTap: () async {
                    final statusCode =
                        await controller.saveOperatingHours(restaurantId);
                    if (statusCode == 200) {
                      Get.back();
                      Get.snackbar(
                        "",
                        "Operating hours saaved",
                        duration: const Duration(seconds: 3),
                        backgroundColor: Tcolor.BACKGROUND_Regaular,
                        titleText: ReuseableText(
                          title: "Done",
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: Tcolor.Text,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        messageText: ReuseableText(
                          title: "Operating hours saved successfully",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Tcolor.Text,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    } else {
                      Get.snackbar(
                        "",
                        "",
                        duration: const Duration(seconds: 3),
                        backgroundColor: Tcolor.BACKGROUND_Regaular,
                        titleText: ReuseableText(
                          title: "Error",
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: Tcolor.Text,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        messageText: ReuseableText(
                          title: "Failed to save hours. Please try again.",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Tcolor.ERROR_Light_2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }
                  },
                  child: CustomButton(
                    title: "Save changes",
                    textColor: Tcolor.Text,
                    btnColor: Tcolor.PRIMARY_Button_color_2,
                    btnWidth: double.infinity,
                    btnHeight: 96.h,
                    raduis: 100.r,
                    fontSize: 32.sp,
                    showArrow: false,
                  ),
                ),
              ),
            ],
          ),
        ),

        // --- Loading overlay ---
        Obx(() {
          if (controller.isLoading.value) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: LottieBuilder.asset(
                    'assets/animation/loading_state.json',
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

// ---------------------------------------------------------------------------
// _TabChip — order type selector pill
// ---------------------------------------------------------------------------
class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: selected
              ? Tcolor.PRIMARY_Button_color_2
              : Tcolor.BACKGROUND_Regaular,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: selected
                ? Tcolor.PRIMARY_Button_color_2
                : Tcolor.TEXT_Label.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: selected ? Tcolor.White : Tcolor.TEXT_Label,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DayRow — one row per day showing toggle + time pickers
// ---------------------------------------------------------------------------
class _DayRow extends StatelessWidget {
  const _DayRow({
    required this.dayLabel,
    required this.dayKey,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
    required this.isReadOnly,
    required this.onToggle,
    required this.onPickOpen,
    required this.onPickClose,
  });

  final String dayLabel;
  final String dayKey;
  final bool isOpen;
  final String openTime;
  final String closeTime;
  final bool isReadOnly;
  final ValueChanged<bool> onToggle;
  final VoidCallback onPickOpen;
  final VoidCallback onPickClose;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isReadOnly ? 0.6 : 1.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: Tcolor.BACKGROUND_Regaular,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isOpen
                ? Tcolor.PRIMARY_Button_color_2.withOpacity(0.4)
                : Tcolor.TEXT_Label.withOpacity(0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day label + open/closed toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dayLabel,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: Tcolor.Text,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      isOpen ? "Open" : "Closed",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: isOpen
                            ? Tcolor.PRIMARY_Button_color_2
                            : Tcolor.TEXT_Label,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Switch(
                      value: isOpen,
                      onChanged: isReadOnly ? null : onToggle,
                      activeColor: Tcolor.PRIMARY_Button_color_2,
                    ),
                  ],
                ),
              ],
            ),

            // Time pickers — only visible when day is open
            if (isOpen) ...[
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: _TimeTile(
                      label: "Opens",
                      time: openTime,
                      onTap: isReadOnly ? null : onPickOpen,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _TimeTile(
                      label: "Closes",
                      time: closeTime,
                      onTap: isReadOnly ? null : onPickClose,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _TimeTile — tappable time display
// ---------------------------------------------------------------------------
class _TimeTile extends StatelessWidget {
  const _TimeTile({
    required this.label,
    required this.time,
    this.onTap,
  });

  final String label;
  final String time;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Tcolor.White,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Tcolor.TEXT_Label.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 20.sp,
                color: Tcolor.TEXT_Label,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              time,
              style: TextStyle(
                fontSize: 28.sp,
                color: Tcolor.Text,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
