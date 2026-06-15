import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/models/rating_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:intl/intl.dart'; // Add this import

// Assuming you have these imports

String formatDate(DateTime createdAt) {
  final DateFormat dateFormatter = DateFormat('dd-MMM-yyyy');
  return dateFormatter.format(createdAt);
}

class RatingTile extends StatelessWidget {
  const RatingTile({
    super.key,
    required this.rating,
  });

  final RatingModel? rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Tcolor.White,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReuseableText(
                    title: rating!.name, // Replace with dynamically set name
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: Tcolor.Text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RatingBarIndicator(
                    itemCount: 5,
                    rating: rating!.rating,
                    unratedColor: Tcolor.BACKGROUND_Dark,
                    itemSize: 26.sp,
                    itemBuilder: (context, i) => ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return Tcolor.Primary_button.createShader(bounds);
                      },
                      child: Icon(
                        HeroiconsSolid.star,
                        size: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              ReuseableText(
                title: rating!.comment,
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Tcolor.TEXT_Body,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.visible,
              ),
              SizedBox(height: 20.h), // Add some spacing
              ReuseableText(
                title: formatDate(rating!.createdAt),
                style: TextStyle(
                  fontSize: 26.sp,
                  color: Tcolor.TEXT_Label,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Divider(
                thickness: 1.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
