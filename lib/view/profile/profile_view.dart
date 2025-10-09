 

import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/profile/tabs/book_mark_videos.dart';
import 'package:be_life_style/view/profile/tabs/my_liked_videos.dart';
import 'package:be_life_style/view/profile/tabs/my_uploads.dart';
import 'package:be_life_style/view/profile/widgets/custom_tab.dart';
import 'package:be_life_style/view/profile/widgets/profile_btns.dart';
import 'package:be_life_style/view/profile/widgets/profile_header.dart';
import 'package:be_life_style/view/profile/widgets/top_bar.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: [
                    TopBar(),
                    SizedBox(height: 19.h),
                    ProfileHeader(),
                    ProfileBtns(),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: CustomTab(icon: AppImages.gridIcon, index: 0)),
                        Flexible(child: CustomTab(icon: AppImages.heartOutline, index: 1)),
                        Flexible(child: CustomTab(icon: AppImages.bookmarkOutline, index: 2)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Consumer<ProfileViewModel>(
          builder: (context, pVM, child) {
            return PageView(
              physics: NeverScrollableScrollPhysics(), // Prevent direct swiping
              controller: pVM.pageController,
              children: [
                MyUploads(userId: null), // null means logged-in user
                MyLikedVideos(userId: null), // null means logged-in user
                BookMarkedVideos(userId: null), // null means logged-in user
              ],
            );
          },
        ),
      ),
    );
  }
}