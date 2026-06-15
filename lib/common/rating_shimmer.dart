import 'package:vendor/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RatingShimer extends StatelessWidget {
  const RatingShimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 241, 240, 240),
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h,),
                    Container(
                      height: 50.h,
                      width: 200.w,
                      
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r)
                       ),
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      height: 100.h,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r)
                       ),
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      height: 100.h,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r)
                       ),
                    ),
                  ],
                ),
              );
  }
}