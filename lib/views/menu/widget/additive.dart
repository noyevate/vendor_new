import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/create_dditive_controller.dart';
import 'package:vendor/hooks/fetch_additives.dart';
import 'package:vendor/models/fetch_additive_model.dart';
import 'package:vendor/views/menu/widget/widget/AdditiveWiget/widget/additive_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class AdditivePage extends HookWidget {
  const AdditivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var restaurantId = box.read("restaurantId");
    restaurantId ??= "12345";

    final hookResult = useFetchAllAdditives(restaurantId);
    final List<FetchAdditiveModel> restaurantAdditive = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
    print("useFetchAllAdditives lenght: ${restaurantAdditive.length} ");

    final refetch = hookResult.refetch;

    final controller = Get.put(AdditiveController());
    controller.setRefetch(refetch);

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
        : restaurantAdditive.isEmpty
            ? Container(
                color: Tcolor.BACKGROUND_Regaular,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 150.h),
                      Container(
                        height: 300.h,
                        width: 300.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/img/empty_additive.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Image.asset(
                      //   "assets/img/empty_additive.png",
                      //   width: 300.w,
                      //   height: 300.h,
                      // ),
                      SizedBox(height: 30.h),
                      ReuseableText(
                        title: "Additives are customizable",
                        style: TextStyle(
                          color: Tcolor.TEXT_Body,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ReuseableText(
                        title: "options for meals. Start by",
                        style: TextStyle(
                          color: Tcolor.TEXT_Body,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ReuseableText(
                        title: "adding your first one.",
                        style: TextStyle(
                          color: Tcolor.TEXT_Body,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.to(() => const CreateAdditive());
                      //   },
                      //   child: const AddFoodWidget(title: 'Add additives'),
                      // ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                child: ListView.builder(
                  itemCount: restaurantAdditive.length,
                  itemBuilder: (context, i) {
                    // Add circular container with plus ico
                    var additive = restaurantAdditive[i];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: AdditiveTile(
                        additive: additive,
                        refetch: refetch,
                      ),
                    );
                  },
                ),
              );
  }
}
