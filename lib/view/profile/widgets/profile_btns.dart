import 'package:be_life_style/config/routes/route_names.dart';
 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../res/components/custom_btn.dart';

 
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
 
import 'package:share_plus/share_plus.dart';
import 'package:be_life_style/config/api_endpoints.dart';


class ProfileBtns extends StatelessWidget {
  const ProfileBtns({super.key});

  @override
  Widget build(BuildContext context) {
    final pVM = context.read<ProfileViewModel>();

    final user = pVM.userDetails;
    if (user == null) return const SizedBox(); // In case it's still loading

    // Construct shareable profile link using your base URL
    final profileUrl = "${ApiEndpoints.baseUrl}/profile/${user.username}";

    return Row(
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
            color: const Color(0xFFF6F6F6),
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: const Color(0xFF202020),
              fontSize: 14.sp,
              letterSpacing: -0.3,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: CustomButton(
            text: "Share profile",
            onPressed: () {
              Share.share(
                "Check out ${user.firstName} ${user.lastName}'s profile on Be Life Style:\n$profileUrl",
                subject: "Be Life Style Profile",
              );
            },
            height: 42.h,
            width: 159.w,
            color: const Color(0xFFF6F6F6),
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: const Color(0xFF202020),
              fontSize: 14.sp,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ],
    );
  }
}

 