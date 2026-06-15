import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/hooks/fetch_new_orders.dart';
import 'package:vendor/models/order_model.dart';
import 'package:vendor/views/orders/widget/widget/order_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class OrderHistory extends HookWidget {
  const OrderHistory({super.key, required this.updateCount});

  final Function(int) updateCount;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final restaurantId = box.read("restaurantId");
    print("resturantID: $restaurantId");
    final hookResult = useFetchNewOrder(restaurantId, "Delivered", "Completed");
    final List<OrderModel> neworders = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateCount(neworders.length); // Update only the new orders count
      });
      return null;
    }, [neworders]);

    return Container(
      height: height,
      width: width,
      color: Tcolor.BACKGROUND_Regaular,
      child: isLoading
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
                      ReuseableText(
                        title: "No  history yet!",
                        style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: ListView.builder(
                      itemCount: neworders.length +
                          1, // Add an extra item for the SizedBox
                      itemBuilder: (context, i) {
                        if (i == neworders.length) {
                          return SizedBox(
                              height: 1000
                                  .h); // Add extra space at the end of the list
                        }
                        var order = neworders[i];
                        return OrderHistoryTile(
                          order: order,
                          refetch: refetch,
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
