import 'package:get/get.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/controller/pack_controller.dart';
import 'package:vendor/hooks/fetch_packs.dart';
import 'package:vendor/models/fetch_packs.dart';
import 'package:vendor/views/menu/widget/widget/PackWidget/pack_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class PacksPage extends HookWidget {
  const PacksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var restaurantId = box.read("restaurantId");
    restaurantId ??= "12345";

    final hookResult = useFetchAllPacks(restaurantId);
    final List<FetchPackModel> packs = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
    final refetch = hookResult.refetch;
    final controller = Get.put(PackController());
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
        : packs.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 150.h),
                    Image.asset(
                      "assets/img/pack_img.png",
                      width: 300.w,
                      height: 300.h,
                    ),
                    SizedBox(height: 30.h),
                    ReuseableText(
                      title: "Add your first pack to get",
                      style: TextStyle(
                        color: Tcolor.TEXT_Body,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ReuseableText(
                      title: "started!",
                      style: TextStyle(
                        color: Tcolor.TEXT_Body,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    //  GestureDetector(
                    //    onTap: () {
                    //      Get.to(() => CreatePack(
                    //            refetch: refetch,
                    //          ));
                    //    },
                    //    child: const AddFoodWidget(title: 'Add Pack'),
                    //  ),
                  ],
                ),
              )
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PackTile(
                      pack: packs,
                      refetch: refetch,
                    ),
                  ),
                ],
              );
  }
}






// : Container(
              //     color: Tcolor.BACKGROUND_Regaular,
              //     padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
              //     child: SizedBox(
              //       width: MediaQuery.of(context).size.width,
              //       height: MediaQuery.of(context).size.height,
              //       child: ListView.builder(
              //         itemCount: packs.length + 2,
              //         itemBuilder: (context, i) {
              //           // Add circular container with plus icon
              //           if (i == packs.length) {
              //             return Align(
              //               alignment: Alignment.bottomRight,
              //               child: GestureDetector(
              //                 onTap: () {
              //                   Get.to(() => const CreatePack());
              //                 },
              //                 child: Container(
              //                   width: 104.w,
              //                   height: 104.h,
              //                   decoration: BoxDecoration(
              //                     shape: BoxShape.circle,
              //                     color: Tcolor.PRIMARY_Button_color_2,
              //                   ),
              //                   child: Icon(
              //                     HeroiconsOutline.plus,
              //                     color: Tcolor.Text,
              //                     size: 32.sp,
              //                   ),
              //                 ),
              //               ),
              //             );
              //           }

              //           // Add extra spacing at the end of the list
              //           if (i == packs.length + 1) {
              //             return SizedBox(height: 500.h);
              //           }

              //           var pack = packs[i];
              //           return PackTile(pack: packs,);
              //         },
              //       ),
              //     ),
              //   ),