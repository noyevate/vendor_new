import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/views/support/widget/add-to_cart.dart';
import 'package:vendor/views/support/widget/cancel_order.dart';
import 'package:vendor/views/support/widget/find_restaurant.dart';
import 'package:vendor/views/support/widget/make_order.dart';
import 'package:vendor/views/support/widget/pickup.dart';
import 'package:vendor/views/support/widget/service_fee.dart';
import 'package:vendor/views/support/widget/support_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void showCustomBottomSheet(
    BuildContext context, Widget content, double height) {
  showModalBottomSheet(
    backgroundColor: Tcolor.White,
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    builder: (context) => Container(
      constraints: BoxConstraints(
        maxHeight: height,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Container(
        child: content,
      ),
    ),
  );
}

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            height: 564.h,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.r),
                bottomRight: Radius.circular(50.r),
              ),
              gradient: Tcolor.SECONDARY_Button_gradient2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                ReuseableText(
                  title: "Support",
                  style: TextStyle(
                    fontSize: 64.sp,
                    fontWeight: FontWeight.w700,
                    color: Tcolor.TEXT_White,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                ReuseableText(
                  title: "How can we help? For further",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: Tcolor.TEXT_White,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ReuseableText(
                  title: "assistance contact us via",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: Tcolor.TEXT_White,
                  ),
                ),
                SizedBox(
                  height: 90.h,
                ),
                Container(
                  height: 96.h,
                  width: 472.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      color: Tcolor.Secondary_Support_Inner_color,
                    ),
                    color: Tcolor.Secondary_Support_color,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final Uri phoneUri = Uri.parse("tel:+2348105533822");
                          if (await canLaunchUrl(phoneUri)) {
                            await launchUrl(phoneUri);
                          } else {
                            print("Could not launch call");
                          }
                        },
                        child: Icon(
                          HeroiconsSolid.phone,
                          size: 48.sp,
                          color: Tcolor.TEXT_White,
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          const facebookAppUrl =
                              "fb://page/chopnowafrica"; // Opens in Facebook app
                          const facebookWebUrl =
                              "https://www.facebook.com/chopnowafrica"; // Fallback to browser

                          try {
                            // Try launching the Facebook app
                            bool launched = await launchUrl(
                              Uri.parse(facebookAppUrl),
                              mode: LaunchMode.externalApplication,
                            );

                            if (!launched) {
                              // If app fails, open the web URL
                              await launchUrl(
                                Uri.parse(facebookWebUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          } catch (e) {
                            // Handle errors or show a message
                            await launchUrl(
                              Uri.parse(facebookWebUrl),
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        child: Icon(
                          FontAwesome.facebook_square,
                          size: 48.sp,
                          color: Tcolor.TEXT_White,
                        ),
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          const instagram =
                              "fb://page/chopnowafrica"; // Opens in Facebook app
                          const instagramWebUrl =
                              "https://www.instagram.com/chopnowafrica?igsh=MWZyNzYwNGRqam1uMA==";

                          try {
                            // Try launching the Facebook app
                            bool launched = await launchUrl(
                              Uri.parse(instagram),
                              mode: LaunchMode.externalApplication,
                            );

                            if (!launched) {
                              // If app fails, open the web URL
                              await launchUrl(
                                Uri.parse(instagramWebUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          } catch (e) {
                            // Handle errors or show a message
                            await launchUrl(
                              Uri.parse(instagramWebUrl),
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        child: Icon(
                          FontAwesome.instagram,
                          size: 48.sp,
                          color: Tcolor.TEXT_White,
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          const twitterApp =
                              "x://page/chopnowafrica"; // Opens in Facebook app
                          const twitterWebApp =
                              "https://x.com/chopnowafrica"; // Fallback to browser

                          try {
                            // Try launching the Facebook app
                            bool launched = await launchUrl(
                              Uri.parse(twitterApp),
                              mode: LaunchMode.externalApplication,
                            );

                            if (!launched) {
                              // If app fails, open the web URL
                              await launchUrl(
                                Uri.parse(twitterWebApp),
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          } catch (e) {
                            // Handle errors or show a message
                            await launchUrl(
                              Uri.parse(twitterWebApp),
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        child: IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset("assets/img/twitter.svg"),
                          iconSize: 40.sp,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          const whatsappAppUrl =
                              "whatsapp://send?phone=+2347053837933&text=Hi%20there!"; // Update with your number and message
                          const whatsappWebUrl =
                              "https://wa.me/2347053837933?text=Hi%20there!"; // Update with your number and message

                          try {
                            bool launched = await launchUrl(
                              Uri.parse(whatsappAppUrl),
                              mode: LaunchMode.externalApplication,
                            );

                            if (!launched) {
                              await launchUrl(
                                Uri.parse(whatsappWebUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          } catch (e) {
                            await launchUrl(
                              Uri.parse(whatsappWebUrl),
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        child: Icon(
                          FontAwesome.whatsapp,
                          size: 48.sp,
                          color: Tcolor.TEXT_White,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCustomBottomSheet(
                          context,
                          const VendorGetStarted(),
                          1200.h, // Set the height for this bottom sheet
                        );
                      },
                      child: const SupportTile(title: "Getting Started"),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        showCustomBottomSheet(
                            context, const ManagingOrders(), 1200.h);
                      },
                      child: const SupportTile(title: "Managing Orders"),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        showCustomBottomSheet(
                            context, const MenuPricing(), 1200.h);
                      },
                      child: const SupportTile(title: "Menu and Pricing"),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        showCustomBottomSheet(
                            context, const SupportMaintenance(), 1200.h);
                      },
                      child:
                          const SupportTile(title: "Support and Maintenance"),
                    ),
                    // SizedBox(height: 20.h),
                    // GestureDetector(
                    //   onTap: () {
                    //     showCustomBottomSheet(
                    //         context, const ServiceFee(), 1200.h);
                    //   },
                    //   child: const SupportTile(title: "Delivery"),
                    // ),
                    // SizedBox(height: 20.h),
                    // GestureDetector(
                    //   onTap: () {
                    //     showCustomBottomSheet(context, const Pickup(), 1200.h);
                    //   },
                    //   child: const SupportTile(title: "Other Questions"),
                    // ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(height: 100.h),
        ],
      ),
    );
  }
}
