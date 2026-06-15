import 'package:get/get.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/order_controller.dart';
import 'package:vendor/hooks/fetch_new_orders.dart';
import 'package:vendor/models/order_model.dart';
import 'package:vendor/views/orders/widget/widget/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class NewOrders extends HookWidget {
  const NewOrders({super.key, required this.updateCount});

  final Function(int) updateCount;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final controller = Get.put(OrderController());
    final restaurantId = box.read("restaurantId");
    restaurantId ?? "12355";
    print("resturantID: $restaurantId");
    final hookResult = useFetchNewOrder(restaurantId, "Placed", "Completed");
    final List<OrderModel> neworders = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateCount(neworders.length); // Update only the new orders count
      });
      return null;
    }, [neworders]);

    return isLoading
        ? Center(
            child: ReuseableText(
              title: "Loading",
              style: TextStyle(
                  fontSize: 32.sp,
                  color: Tcolor.Primary_New,
                  fontWeight: FontWeight.w400),
            ),
          )
        : neworders.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/empty_order.png",
                      height: 200.h,
                      width: 200.w,
                      color: Tcolor.Primary_New,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ReuseableText(
                      title: "No new orders!",
                      style: TextStyle(
                          color: Tcolor.TEXT_Body,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                child: ListView.builder(
                  itemCount: neworders.length,
                  itemBuilder: (context, i) {
                    var order = neworders[i];
                    return OrderTile(
                      order: order,
                      refetch: refetch,
                    );
                  },
                ),
              );
  }
}
