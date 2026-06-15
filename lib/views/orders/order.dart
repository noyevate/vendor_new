import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/order_controller.dart';
import 'package:vendor/views/orders/widget/active_orders.dart';
import 'package:vendor/views/orders/widget/new_orders.dart';
import 'package:vendor/views/orders/widget/order_history.dart';
import 'package:vendor/views/orders/widget/preparing_order.dart';
import 'package:vendor/views/orders/widget/rejected_orders.dart';
import 'package:vendor/views/orders/widget/widget/order_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart'; // Import GetX

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, this.selectedIndex});

  final int? selectedIndex;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: orderList.length, vsync: this);

    if (widget.selectedIndex != null) {
      // Set initial tab index if provided
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tabController.animateTo(widget.selectedIndex!);
      });
    }

    // final args = Get.arguments;
    // if (args != null && args is Map && args.containsKey('tabIndex')) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _tabController.animateTo(args['tabIndex']);
    //   });
    // }

    final controller = Get.put(OrderController());
    controller.setTabController(_tabController);
  }

  // final int newOrderCount = NewOrder().
  int newOrderCount = 0; // Local state for new order count

  // Method to update the order count
  void updateNewOrderCount(int count) {
    setState(() {
      newOrderCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.put(OrderController());
    final box = GetStorage();
    final restaurantId = box.read('restaurantId');

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.h),
        child: Column(
          children: [
            Container(
              height: 30.h,
              color: Tcolor.SUCCESS_Light_2,
            ),
            Obx(() {
              return controller.showOrderRejected.value
                  ? Container(
                      color: Tcolor.SUCCESS_Light_2,
                      width: double.infinity,
                      height: 120.h,
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Row(
                        children: [
                          Icon(
                            HeroiconsSolid.checkCircle,
                            color: Tcolor.SUCCESS_Reg,
                            size: 32.sp,
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReuseableText(
                                  title: "Order rejected",
                                  style: TextStyle(
                                      color: Tcolor.SUCCESS_Reg,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      controller.showOrderRejected.value =
                                          false;
                                    },
                                    child: Icon(
                                      HeroiconsOutline.xMark,
                                      color: Tcolor.TEXT_Placeholder,
                                      size: 40.sp,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ))
                  : SafeArea(
                    child: Container(
                        padding: EdgeInsets.only(left: 30.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Space between text and switch
                          children: [
                            ReuseableText(
                              title: "Order",
                              style: TextStyle(
                                  color: Tcolor.Text,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize
                                  .min, // Shrinks the row to fit its content
                              children: [
                                ReuseableText(
                                  title: "Accepting orders",
                                  style: TextStyle(
                                    color: Tcolor.Text,
                                    fontSize: 28.sp,
                                  ),
                                ),
                                Flexible(
                                  // Replaces Spacer or Expanded with Flexible
                                  fit: FlexFit
                                      .loose, // Allows the child to take only as much space as it needs
                                  child: Obx(
                                    () => Transform.scale(
                                      scale: 1.2
                                          .sp, // Adjust this value to resize the switch
                                      child: Switch.adaptive(
                                        value: controller.isSwitched.value,
                                        onChanged: (value) {
                                          if (!controller.loading.value) {
                                            controller.toggleSwitch(
                                                restaurantId, value);
                                          } // Call the controller method
                                        },
                                        inactiveThumbColor: Tcolor
                                            .TEXT_Label, // Thumb color when inactive
                                        activeTrackColor: Tcolor
                                            .Primary_Checkbox_icon, // Track color when active
                                        inactiveTrackColor: Tcolor
                                            .BACKGROUND_Dark, // Track color when inactive
                                        thumbColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          if (states
                                              .contains(MaterialState.selected)) {
                                            return Colors
                                                .white; // White thumb when active
                                          }
                                          return Tcolor
                                              .BACKGROUND_Regaular; // Regular thumb when inactive
                                        }),
                                        trackOutlineColor:
                                            MaterialStateProperty.all(Colors
                                                .transparent), // Remove any border or outline
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ); // Empty widget if not shown
            }),
            Container(
              padding: EdgeInsets.only(left: 30.w),
              decoration: BoxDecoration(color: Tcolor.White),
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  OrderTabs(
                        tabController: _tabController,
                        counts: controller.orderCounts, // Use the local state
                      ),
                    
                  
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Tcolor.BACKGROUND_Regaular,
        child: TabBarView(controller: _tabController, children: [
          NewOrders(updateCount: (count) {
            controller.updateOrderCount(0, count); // Update for new orders
          }),
          PreparingOrders(updateCount: (count) {
            controller.updateOrderCount(0, count); // Update for new orders
          }),
          ActiveOrders(updateCount: (count) {
            controller.updateOrderCount(0, count); // Update for new orders
          }),
          OrderHistory(updateCount: (count) {
            controller.updateOrderCount(0, count); // Update for new orders
          }),
          RejectedOrders(updateCount: (count) {
            controller.updateOrderCount(0, count); // Update for new orders
          }),
        ]),
      ),
    );
  }
}
