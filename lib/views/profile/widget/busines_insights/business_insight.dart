import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/format_price.dart';
import 'package:vendor/common/page_title.dart';
import 'package:vendor/common/rating_shimmer.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/hooks/fetch_all_restaurant_orders.dart';
import 'package:vendor/models/fetch_user_restaurant.dart';
import 'package:vendor/models/loging_response_model.dart';
import 'package:vendor/models/order_model.dart';
import 'package:vendor/models/rating_model.dart';
import 'package:vendor/views/profile/widget/busines_insights/busines_insight_container.dart';
import 'package:vendor/views/profile/widget/busines_insights/business_date_filter.dart';
import 'package:vendor/views/profile/widget/busines_insights/rating_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import '../../../../controller/businnessInsight_controller.dart';

double safeDoubleParse(dynamic value) {
  if (value == null) return 0.0;
  return double.tryParse(value.toString()) ?? 0.0;
}

class RestaurantBusinessInsight extends HookWidget {
  const RestaurantBusinessInsight({
    super.key,
    this.restaurant,
  });

  final LoginResponseModel? restaurant;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final restaurantId = box.read("restaurantId");
    final hookResult = useFetchRestaurantOrders(restaurantId);
    final List<OrderModel> orders = hookResult.data ?? [];
    final isLoading1 = hookResult.isLoading;
    final controller = Get.put(BusinesInsightController());

    if (!isLoading1) {
      controller.initializeInsightData(orders);
    }

    final restaurantRatings = useState<List<RatingModel>>([]);

    final tabController = useTabController(initialLength: 6);

    useEffect(() {
      Future.microtask(() async {
        final ratings = await controller.fetchRestaurantRating(restaurantId);
        restaurantRatings.value = ratings;

        // Group the ratings by range and store them in the controller
        controller.groupedRatings.value =
            controller.groupRatingsByRange(ratings);
      });
      return null;
    }, [restaurantId]);

     final List<RatingModel>? allRatings =
        controller.groupedRatings["0.0-5.0"];

        final List<RatingModel>? fiveStarRatings =
        controller.groupedRatings["4.5–5.0"];

    final List<RatingModel>? fourStarRatings =
        controller.groupedRatings["3.5–4.4"];


     final List<RatingModel>? threeStarRatings =
        controller.groupedRatings["2.5–3.4"];

    final List<RatingModel>? twoStarRatings =
        controller.groupedRatings["1.5–2.4"];

      final List<RatingModel>? oneStarRatings =
        controller.groupedRatings["0.0–1.4"];

     

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: Padding(
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
      body: Container(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                controller.clearField();
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Tcolor.White,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r))),
                        height: 1000.h,
                        width: width,
                        child: BusinessDateFilter(
                          order: orders,
                        ),
                      );
                    });
              },
              child: Container(
                height: 72.h,
                width: 270.w,
                padding: EdgeInsets.only(left: 15.sp),
                decoration: BoxDecoration(
                    color: Tcolor.BACKGROUND_Regaular,
                    border: Border.all(color: Tcolor.BORDER_Light),
                    borderRadius: BorderRadius.circular(16.r)),
                child: Row(
                  children: [
                    Icon(
                      HeroiconsOutline.calendar,
                      size: 40.sp,
                      color: Tcolor.TEXT_Label,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Obx(() {
                      return ReuseableText(
                        title: controller.filterName.value,
                        style: TextStyle(
                            color: Tcolor.Text,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w400),
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => BusinesInsightContainer(
                      title1: 'Total orders',
                      title2: formatPrice(controller.totalOrder.value),
                      title3: '',
                      title4: "",
                    )),
                Obx(() => BusinesInsightContainer(
                      title1: 'Total amount',
                      // title2: formatPrice(controller.totalAmount.value),
                      title2: formatPrice(controller.totalAmount.value),
                      title3: '',
                      title4: "₦",
                    )),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => BusinesInsightContainer(
                      title1: 'Rejected orders',
                      title2: formatPrice(controller.rejectedOrder.value),
                      title3: '',
                      title4: "",
                    )),
                Obx(() => BusinesInsightContainer(
                      title1: 'Active orders',
                      title2: formatPrice(controller.activeOrder.value),
                      title3: '',
                      title4: "",
                    )),
              ],
            ),
            SizedBox(height: 40.h),
            ReuseableText(
              title: "Reviews",
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  color: Tcolor.Text),
            ),
            SizedBox(height: 40.h),
            Container(
              height: 100.h,
              width: width,
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              decoration: BoxDecoration(
                color: Tcolor.Secondary_S2,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReuseableText(
                    title: "${restaurant!.ownedRestaurant!.rating.toString()}/5.0",
                    style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w500,
                        color: Tcolor.White),
                  ),
                  RatingBarIndicator(
                    itemCount: 5,
                    rating:   safeDoubleParse(restaurant!.ownedRestaurant!.rating.toString()),
                    unratedColor: Tcolor.BACKGROUND_Dark,
                    itemSize: 42.sp,
                    itemBuilder: (context, i) => Icon(
                      HeroiconsSolid.star,
                      size: 24.sp,
                      color: Tcolor.PRIMARY_Button_color_2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            AnimatedBuilder(
              animation:
                  tabController, // Listen for changes in the TabController
              builder: (context, child) {
                return TabBar(
                  controller: tabController,
                  dividerColor: Tcolor.White,
                  physics: const AlwaysScrollableScrollPhysics(),
                  isScrollable: true,
                  indicatorWeight: 0,
                  tabAlignment: TabAlignment.start,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Tcolor.White),
                    color: Tcolor.White,
                  ),
                  labelPadding: EdgeInsets.zero,
                  // splashBorderRadius: BorderRadius.circular(25.r),
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  labelColor: Tcolor.Secondary_S2,
                  labelStyle: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                    color: Tcolor.White,
                  ),
                  unselectedLabelColor: Tcolor.TEXT_Placeholder,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                    color: Tcolor.TEXT_Placeholder,
                  ),
                  tabs: List.generate(
                    6,
                    (index) {
                      final titles = [
                        "All(${controller.isLoading || allRatings == null ?"0": allRatings.length})",
                        "5star(${controller.isLoading || fiveStarRatings == null ?"0": fiveStarRatings.length})",
                        "4star(${controller.isLoading || fourStarRatings == null ?"0": fourStarRatings.length})",
                        "3star(${controller.isLoading || threeStarRatings == null ?"0": threeStarRatings.length})",
                        "2star(${controller.isLoading || twoStarRatings == null ?"0": twoStarRatings.length})",
                        "1star(${controller.isLoading || oneStarRatings == null ?"0": oneStarRatings.length})",
                      ];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w), // Spacing between tabs
                        child: GestureDetector(
                          onTap: () {
                            tabController.animateTo(index); // Smooth switching
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: tabController.index == index
                                    ? Tcolor
                                        .SECONDARY_Button // Selected border color
                                    : Tcolor
                                        .BORDER_Light, // Unselected border color
                              ),
                              borderRadius: BorderRadius.circular(15.r),
                              color: tabController.index == index
                                  ? Tcolor.SECONDARY_T2 // Selected background
                                  : Colors.transparent, // Unselected background
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 30.w),
                            child: Center(
                              child: ReuseableText(
                                title: titles[index],
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500,
                                  color: tabController.index == index
                                      ? Tcolor.Text // Selected text color
                                      : Tcolor.Text, // Unselected text color
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            if (controller.isLoading)
              const RatingShimer()
            else
              Expanded(
                child: TabBarView(
                  controller: tabController, // Attach the TabController
                  children: [
                    RatingPage(
                      ratingList: allRatings,
                    ),
                    RatingPage(
                      ratingList: fiveStarRatings,
                    ),
                    RatingPage(
                      ratingList: fourStarRatings,
                    ),
                    RatingPage(
                      ratingList: threeStarRatings,
                    ),
                    RatingPage(
                      ratingList: twoStarRatings,
                    ),
                    RatingPage(
                      ratingList: oneStarRatings,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
