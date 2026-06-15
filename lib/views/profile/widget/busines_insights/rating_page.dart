import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/reusable_text_widget.dart';
import 'package:vendor/models/rating_model.dart';
import 'package:vendor/views/profile/widget/busines_insights/rating_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({
    super.key,
    this.ratingList,
  });
  final List<RatingModel>? ratingList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Tcolor.White,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ratingList == null || ratingList!.isEmpty
                  ? Center(
                      child: Text(
                        'No ratings available',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Tcolor.White,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      ratingList!.length,
                      (i) {
                        RatingModel rating = ratingList![i];
                        return RatingTile(
                          rating: rating,
                        );
                      },
                    ),
                    SizedBox(height: 500.h), // Add extra space at the end if needed
                  ],
                ),
              ),
                  
                  
                  
                  
                  // : SingleChildScrollView(
                  //   child: Padding(
                  //       padding: EdgeInsets.symmetric(
                  //           horizontal: 12.w, vertical: 10.h),
                  //       child: Column(
                  //         children: List.generate(ratingList!.length, (i) {
                  //           if (i == ratingList!.length + 1) {
                  //             return SizedBox(height: 500.h);
                  //           }
                  //           RatingModel rating = ratingList![i];
                  //           return RatingTile(
                  //             rating: rating,
                  //           );
                  //         }),
                  //       ),
                  //     ),
                  // ),
            ),
          ],
        ),
      ),
    );
  }
}
