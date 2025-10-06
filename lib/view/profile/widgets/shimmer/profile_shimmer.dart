import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';


class ProfileHeaderShimmer extends StatelessWidget {
  const ProfileHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 34.h, width: 34.w),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
                height: 110.h,
                width: 110.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                ),
                ),
          ),

          Container(
              height: 34.h,
              width: 34.w,
              padding: EdgeInsets.only(right: 19.w),
              child: Icon(CupertinoIcons.gift)),
        ],
      ),
      SizedBox(height: 24.h),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 24.h,
          width: 120.w,
          decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(12),
              color: Colors.white
          ),
        ),
      ),
      SizedBox(height: 4.h),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 20.h,
          width: 80.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white
          ),
        ),
      ),
      SizedBox(height: 12.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(" ",
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700, color: Color(0xFF202020))),
              Text("Following",
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontSize: 14.sp, color: Color(0xFF202020))),
            ],
          ),
          Column(
            children: [
              Text(" ",
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700, color: Color(0xFF202020))),
              Text("Followers",
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontSize: 14.sp, color: Color(0xFF202020))),
            ],
          ),
          Column(
            children: [
              Text("",
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700, color: Color(0xFF202020))),
              Text("Likes",
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontSize: 14.sp, color: Color(0xFF202020))),
            ],
          ),
        ],
      ),
      SizedBox(height: 12.h),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 10.h,
          width: 300.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white
          ),
        ),
      ),
      SizedBox(height: 5.h,),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 10.h,
          width: 240.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white
          ),
        ),
      ),

      SizedBox(height: 16.h),

    ],);
  }
}
