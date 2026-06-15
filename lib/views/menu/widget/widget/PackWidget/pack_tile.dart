import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/custom_button.dart';
import 'package:vendor/common/format_price.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/controller/pack_controller.dart';
import 'package:vendor/models/fetch_packs.dart';
import 'package:vendor/views/menu/widget/widget/PackWidget/edit_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class PackTile extends StatelessWidget {
  const PackTile({super.key, required this.pack, this.refetch});
  final List<FetchPackModel> pack;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: Tcolor.BACKGROUND_Regaular,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(
              top: 30.h, left: 30.w, right: 30.w, bottom: 30.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Tcolor.White,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: List.generate(pack.length, (index) {
              FetchPackModel packs = pack[index];
              return Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                              title: packs.packName,
                              style: TextStyle(
                                fontSize: 28.sp,
                                color: Tcolor.Text,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "₦",
                                      style: TextStyle(
                                        fontSize: 25.sp,
                                        color: Tcolor.TEXT_Placeholder,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReuseableText(
                                      title: formatPrice(packs.price),
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Tcolor.TEXT_Placeholder,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.w),
                                Container(
                                  decoration: BoxDecoration(
                                    color: packs.isAvailable
                                        ? Tcolor.SUCCESS_Reg
                                        : Tcolor.ERROR_Reg,
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 5.h),
                                      child: ReuseableText(
                                        title: packs.isAvailable
                                            ? "In-stock"
                                            : "Out of stock",
                                        style: TextStyle(
                                          fontSize: 28.sp,
                                          color: Tcolor.White,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Tcolor.White,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.r),
                                                topRight: Radius.circular(20.r))),
                                        height: 1250.h,
                                        width: width,
                                        child: UpdatePack(
                                          id: packs.id,
                                          refetch: refetch!,
                                        ),
                                      );
                                    });
                              },
                              child: Icon(
                                HeroiconsOutline.pencil,
                                color: Tcolor.TEXT_Label,
                                size: 34.sp,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () {
                                _showPopup(
                                    context,
                                    "Delete pack",
                                    "Are you sure you want to delete this pack?",
                                    packs.id);
                              },
                              child: Icon(
                                HeroiconsOutline.trash,
                                color: Tcolor.TEXT_Label,
                                size: 34.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }


  void _showPopup(
      BuildContext context, String title1, String title2, String id ) {
        final controller = Get.put(PackController());
    showDialog(
        context: context,
        barrierColor:
            const Color.fromRGBO(18, 20, 25, 0.8), // Dark overlay color
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: 530.w,
              height:  220.h,
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, bottom: 10.h, top: 30.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReuseableText(
                    title: title1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.sp,
                        color: Tcolor.Text),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ReuseableText(
                    title: title2,
                    style: TextStyle(
                        color: Tcolor.TEXT_Label,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the Row content
                    children: [
                      CustomButton(
                        title: "No, Cancel",
                        showArrow: false,
                        btnColor: Tcolor.White,
                        btnWidth: 220.w,
                        btnHeight: 72.h,
                        textColor: Tcolor.TEXT_Body,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w400,
                        onTap: () async {
                          Get.back();
                        },
                      ),
                      SizedBox(
                          width: 10.w), // Space between buttons and divider
                      Container(
                        height: 50.h,
                        width: 5.w,
                        color: Tcolor.BACKGROUND_Dark,
                      ),
                      SizedBox(width: 10.w), // Space between divider and button
                      CustomButton(
                        title:
                            "Yes, Delete", // Changed title for differentiation
                        showArrow: false,
                        btnColor: Tcolor.White,
                        btnWidth: 220.w,
                        btnHeight: 72.h,
                        textColor: Tcolor.ERROR_Reg,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w400,

                        onTap: () async {
                          controller.deletePack(id, refetch!);
                          Get.back();
                          
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}





// class PacksPage extends HookWidget {
//   const PacksPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hookResult = useFetchAllPacks("668552324409ef9c2bb165eb");
//     final List<FetchPackModel> packs = hookResult.data ?? [];
//     final bool isLoading = hookResult.isLoading;
//     final Exception? error = hookResult.error;
//     final refetch = hookResult.refetch;

//     return Scaffold(
//       backgroundColor: Tcolor.BACKGROUND_Regaular,
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : packs.isEmpty
//               ? Container(
//                   color: Tcolor.BACKGROUND_Regaular,
//                   child: Center(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 150.h),
//                         Image.asset(
//                           "assets/img/checkers.png",
//                           width: 300.w,
//                           height: 300.h,
//                         ),
//                         SizedBox(height: 30.h),
//                         ReuseableText(
//                           title: "Add your first pack to get",
//                           style: TextStyle(
//                             color: Tcolor.TEXT_Body,
//                             fontSize: 28.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         ReuseableText(
//                           title: "started!",
//                           style: TextStyle(
//                             color: Tcolor.TEXT_Body,
//                             fontSize: 28.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         SizedBox(height: 30.h),
//                         GestureDetector(
//                           onTap: () {
//                             Get.to(() => const CreatePack());
//                           },
//                           child: const AddFoodWidget(title: 'Add Pack'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: PackTile(
//                       pack: packs,
//                       refetch: refetch,
//                     ),
//                   ),
//                 ),
//     );
//   }
// }
