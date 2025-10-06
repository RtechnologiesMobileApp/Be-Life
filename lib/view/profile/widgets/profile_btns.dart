import 'package:be_life_style/config/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/components/custom_btn.dart';

class ProfileBtns extends StatelessWidget {
  const ProfileBtns({super.key});

  @override
  Widget build(BuildContext context) {
    return    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: CustomButton(
                text: "Edit profile",
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.editProfileScreen);
                },
                height: 42.h,
                width: 199.w,
                color: Color(0xFFF6F6F6),
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Color(0xFF202020), fontSize: 14.sp, letterSpacing: -0.3))),
        SizedBox(width: 8.w),
        Flexible(
            child: CustomButton(
                text: "Share profile",
                onPressed: () {},
                height: 42.h,
                width: 159.w,
                color: Color(0xFFF6F6F6),
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Color(0xFF202020), fontSize: 14.sp, letterSpacing: -0.3))),
      ],
    );
  }
}
