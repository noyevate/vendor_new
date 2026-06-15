// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vendor/controller/rider_tracking_controller.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vendor/common/reusable_text_widget.dart';


class TrackRiderLocation extends StatelessWidget {
  const TrackRiderLocation({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX #4: CLEAN LIFECYCLE MANAGEMENT
    // The controller is created here. GetX automatically calls its onInit method.
    // When this page is removed, GetX will call the controller's onClose method.
    final RiderTrackingController controller = Get.put(RiderTrackingController());

    // The 'ever' listener can be set up here, it's safe.
    ever(controller.trackingState, (state) {
      if (state == TrackingState.error) {
        Fluttertoast.showToast(
            msg: "Could not retrieve rider's location. Please try again later.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Tcolor.SECONDARY_Button,
        onPressed: () {
          controller.fetchPlacesNames();
          Get.bottomSheet(
            
            LocationHistoryShet(),
            backgroundColor: Tcolor.White,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            
          );
        }, 
        label: ReuseableText(title: "View Route Details", style: TextStyle(fontSize: 23.sp, color: Tcolor.White, ))
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                initialCameraPosition: controller.initialCameraPosition.value,
                markers: controller.markers.value,
                polylines: controller.polylines.value,
                onMapCreated: controller.onMapCreated,
              )),
          Obx(() {
            if (controller.trackingState.value == TrackingState.loading) {
              return Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      ReuseableText(
                        title: 'Finding Your Rider...',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),

          Positioned(
            left: 20.w,
            top: 60.h,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 90.h,
                width: 90.h,
                decoration: BoxDecoration(
                  color: Tcolor.White,
                  shape: BoxShape.circle
                ),
                child: Center(
                  child: Icon(
                                HeroiconsMini.chevronLeft,
                                color: Tcolor.Text,
                              ),
                ),
              ),
            ))
            
         
        ],
      ),
    );
  }
}



class LocationHistoryShet extends StatelessWidget {
  const LocationHistoryShet({super.key});

  @override
  Widget build(BuildContext context) {
    final RiderTrackingController controller = Get.put(RiderTrackingController());
    return Container(
      // height: 300.h,
      width: double.infinity,
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h, bottom: 30.h),
      // decoration: BoxDecoration(
      //   color: Tcolor.White
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReuseableText(title: "Rider's Path", style: TextStyle(fontSize: 32.sp, color: Tcolor.Text, fontWeight: FontWeight.bold)),
          const Divider(thickness: 1, height: 10),

          Obx(() {
            if( controller.isFetchingPlaces.value) {
              return Center(heightFactor: 3, child: CircularProgressIndicator(),);
            }
            return Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.placeNames.length,
                itemBuilder: (contex, index) {
                  return ListTile(
                    leading: Icon(Icons.location_on_outlined, color: Colors.blue),
                    title:ReuseableText(title: controller.placeNames[index], style: TextStyle(fontSize: 32.sp, color: Tcolor.Text, fontWeight: FontWeight.bold)),
                    dense: true,
                  );
                }
              ),
            );
          })
        ],
      ),
    );
  }
}