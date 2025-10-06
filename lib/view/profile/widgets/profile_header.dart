import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/view/profile/widgets/shimmer/profile_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/app_images.dart';
import '../../../view_model/profile/profile_view_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context,pVM,_) {
        return pVM.isLoading?ProfileHeaderShimmer():Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 34.h, width: 34.w),
              SizedBox(
                  height: 110.h,
                  width: 110.w,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 110.h,
                        width: 110.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(98.r),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: pVM.userDetails!.profilePicture,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
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

                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                      // Image.asset(AppImages.profileImg, fit: BoxFit.cover),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(AppImages.camIcon)),
                    ],
                  )),
              Container(
                  height: 34.h,
                  width: 34.w,
                  padding: EdgeInsets.only(right: 19.w),
                  child: Icon(CupertinoIcons.gift)),
            ],
          ),
          SizedBox(height: 24.h),

          // Username & Bio
          Text(pVM.userDetails!.firstName+pVM.userDetails!.lastName,
              style: Theme.of(context).textTheme.headlineMedium!
                  .copyWith(color: Colors.black, fontSize: 24.sp)),
          SizedBox(height: 4.h),
          Text("@${pVM.userDetails!.username}",
              style: Theme.of(context).textTheme.bodyMedium!
                  .copyWith(color: Color(0xFF202020), fontSize: 14.sp)),
          SizedBox(height: 12.h),

          // Stats Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.followingScreen,
                    arguments: {'userId': pVM.userDetails!.id, 'isFollowers': false},
                  );
                },
                child: Column(
                  children: [
                    Text("${pVM.userDetails!.followingCount ?? "0"}",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w700, color: Color(0xFF202020))),
                    Text("Following",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontSize: 14.sp, color: Color(0xFF202020))),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.followersScreen,
                    arguments: {'userId': pVM.userDetails!.id, 'isFollowers': true},
                  );
                },
                child: Column(
                  children: [
                    Text("${pVM.userDetails!.followersCount ?? "0"}",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w700, color: Color(0xFF202020))),
                    Text("Followers",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontSize: 14.sp, color: Color(0xFF202020))),
                  ],
                ),
              ),
              Column(
                children: [
                  Text("${pVM.userDetails!.likesCount ?? "0"}",
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

          // Bio
          Text(
            textAlign: TextAlign.center,
            "Adventure seeker 🌍 Travel enthusiast ✈️ Sharing the world's most beautiful destinations 🌄",
            style: Theme.of(context).textTheme.bodyLarge!
                .copyWith(fontSize: 14.sp, color: Color(0xFF202020), letterSpacing: 0.3),
          ),
          SizedBox(height: 16.h),

        ],);
      }
    );
  }
}
