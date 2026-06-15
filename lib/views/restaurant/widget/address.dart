// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/common/size.dart';
import 'package:vendor/views/auth/widget/field_widget.dart';
import 'package:vendor/views/shimmer/address_shimmer;.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:http/http.dart' as http;

class AddressSearchPage extends StatefulHookWidget {
  const AddressSearchPage({super.key});

  @override
  State<AddressSearchPage> createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends State<AddressSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _placeList = [];

  var address = "";
  var postalCode = "";
  var latitude = 0.0;
  var longitude = 0.0;

  bool isLoadingResults = false; // New loading state for shimmer

  // Handle search query changes
  _onSeachedChanged(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      setState(() {
        isLoadingResults = true; // Show shimmer when typing starts
      });

      final url = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchQuery&key=$googleApiKey");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
          isLoadingResults = false; // Stop shimmer when results arrive
        });
      } else {
        setState(() {
          _placeList = [];
          isLoadingResults = false; // Stop shimmer even on error
        });
      }
    } else {
      setState(() {
        _placeList = [];
        isLoadingResults = false; // Stop shimmer when search is empty
      });
    }
  }

  // Fetch place details based on place ID
  // Future _getPlaceDetails(String placeId) async {
  //   final url = Uri.parse(
  //       "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey");
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final location = json.decode(response.body);
  //     final lat = location['result']['geometry']['location']['lat'] as double;
  //     final lng = location['result']['geometry']['location']['lng'] as double;
  //     final addressLine = location['result']['formatted_address'];

  //     String postal_code = '';
  //     final addressComponents = location['result']['address_components'];
  //     for (var component in addressComponents) {
  //       if (component['types'].contains('postal_code')) {
  //         postal_code = component['long_name'];
  //         break;
  //       }
  //     }

  //     if (mounted) {
  //       setState(() {
  //         address = addressLine;
  //         postalCode = postal_code.isNotEmpty ? postal_code : 'N/A';
  //         latitude = lat;
  //         longitude = lng;
  //       });
  //     }
  //   }
  // }

  Future _getPlaceDetails(String placeId) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final location = json.decode(response.body);
      final lat = location['result']['geometry']['location']['lat'] as double;
      final lng = location['result']['geometry']['location']['lng'] as double;
      final addressLine = location['result']['formatted_address'];

      String postal_code = '';
      final addressComponents = location['result']['address_components'];
      for (var component in addressComponents) {
        if (component['types'].contains('postal_code')) {
          postal_code = component['long_name'];
          break;
        }
      }

      if (mounted) {
        setState(() {
          address = addressLine;
          postalCode = postal_code.isNotEmpty ? postal_code : 'N/A';
          latitude = lat;
          longitude = lng;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = _searchController.text.isNotEmpty;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReuseableText(
                      title: "Delivery address",
                      style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w700,
                          color: Tcolor.Text),
                    ),
                    Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: Tcolor.BACKGROUND_Dark,
                        borderRadius: BorderRadius.circular(60.r),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          HeroiconsOutline.xMark,
                          color: Tcolor.Text,
                          size: 32.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                FieldWidget(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Enter your address",
                  hintColor: Tcolor.TEXT_Placeholder,
                  hintFontSize: 30.sp,
                  hintFontWeight: FontWeight.w600,
                  cursorHeight: 30.sp,
                  cursorColor: Tcolor.Primary,
                  controller: _searchController,
                  onChanged: _onSeachedChanged,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
          color: Tcolor.White,
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
          child: isLoadingResults
              ? const AddressShimmer()
              : isSearching
                  ? (_placeList.isEmpty
                      ? const AddressShimmer()
                      : ListView.builder(
                          itemCount: _placeList.length,
                          itemBuilder: (context, index) {
                            String cleanDescription = _placeList[index]
                                    ['description']
                                .replaceAll(
                                    RegExp(r'(\b[a-zA-Z0-9]{3,6}\b)$',
                                        caseSensitive: false),
                                    '') // Removes random 3-6 character codes at the end
                                .replaceAll(RegExp(r'\b\d{4,}\b'),
                                    '') // Remove long numeric codes (if needed)
                                .replaceAll(RegExp(r'\s{2,}'),
                                    ' ') // Remove extra spaces
                                .trim();
                            return Container(
                              color: Tcolor.White,
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                title: Row(
                                  children: [
                                    Icon(
                                      HeroiconsOutline.mapPin,
                                      size: 40.sp,
                                    ),
                                    SizedBox(width: 20.w),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: ReuseableText(
                                        title: cleanDescription.isNotEmpty
                                            ? cleanDescription
                                            : _placeList[index]['description'],
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Tcolor.Text,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  // Fetch place details on tap
                                  await _getPlaceDetails(
                                      _placeList[index]["place_id"]);
                                  // Return the selected address, postalCode, latitude, and longitude
                                  Get.back(result: {
                                    'address': cleanDescription,
                                    'postalCode': postalCode,
                                    'latitude': latitude,
                                    'longitude': longitude,
                                  });
                                },
                              ),
                            );
                          },
                        ))
                  : const SizedBox.shrink()),
    );
  }
}
