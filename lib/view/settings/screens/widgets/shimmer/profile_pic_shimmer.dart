import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePicShimmer extends StatelessWidget {
  const ProfilePicShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return   Shimmer.fromColors(
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
    );
  }
}
