 

import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/model/user_model/other_user_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/res/components/custom_btn.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/profile/tabs/book_mark_videos.dart';
import 'package:be_life_style/view/profile/tabs/my_liked_videos.dart';
import 'package:be_life_style/view/profile/tabs/my_uploads.dart';
import 'package:be_life_style/view_model/user/other_user_profile_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OtherUserProfileView extends StatefulWidget {
  final int userId;
  
  const OtherUserProfileView({super.key, required this.userId});

  @override
  State<OtherUserProfileView> createState() => _OtherUserProfileViewState();
}

class _OtherUserProfileViewState extends State<OtherUserProfileView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtherUserProfileViewModel(userRepo: getIt<UserRepo>()),
      child: _OtherUserProfileContent(userId: widget.userId),
    );
  }
}

class _OtherUserProfileContent extends StatefulWidget {
  final int userId;
  
  const _OtherUserProfileContent({required this.userId});

  @override
  State<_OtherUserProfileContent> createState() => _OtherUserProfileContentState();
}

class _OtherUserProfileContentState extends State<_OtherUserProfileContent> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OtherUserProfileViewModel>().fetchUserProfile(widget.userId);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OtherUserProfileViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (viewModel.userProfile == null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
            ),
            body: Center(
              child: Text(
                'User not found',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }

        return _buildProfileContent(context, viewModel);
      },
    );
  }

  Widget _buildProfileContent(BuildContext context, OtherUserProfileViewModel viewModel) {
    final user = viewModel.userProfile!;
    
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    children: [
                      _buildTopBar(),
                      SizedBox(height: 19.h),
                      _buildProfileHeader(user, viewModel),
                      _buildProfileBtns(user, viewModel),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: _buildCustomTab(icon: AppImages.gridIcon, index: 0)),
                          Flexible(child: _buildCustomTab(icon: AppImages.heartOutline, index: 1)),
                          Flexible(child: _buildCustomTab(icon: AppImages.bookmarkOutline, index: 2)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              MyUploads(userId: user.id),
              MyLikedVideos(userId: user.id),
              BookMarkedVideos(userId: user.id),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 24.h),
        ),
        Text("Profile",
            style: Theme.of(context).textTheme.headlineMedium!
                .copyWith(fontSize: 18.sp, color: Colors.black)),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_horiz, color: Colors.black, size: 24.h),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(OtherUserModel user, OtherUserProfileViewModel viewModel) {
    return Column(
      children: [
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
                        imageUrl: user.profilePicture,
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
                ],
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

        // Username & Bio
        Text(user.firstName + user.lastName,
            style: Theme.of(context).textTheme.headlineMedium!
                .copyWith(color: Colors.black, fontSize: 24.sp)),
        SizedBox(height: 4.h),
        Text("@${user.username}",
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
                  arguments: {'userId': user.id, 'isFollowers': false},
                );
              },
              child: Column(
                children: [
                  Text("${user.followingCount ?? "0"}",
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
                  arguments: {'userId': user.id, 'isFollowers': true},
                );
              },
              child: Column(
                children: [
                  Text("${user.followersCount ?? "0"}",
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
                Text("${user.likesCount ?? "0"}",
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
      ],
    );
  }

  Widget _buildProfileBtns(OtherUserModel user, OtherUserProfileViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CustomButton(
            text: viewModel.isFollowLoading 
              ? "Loading..." 
              : (user.isFollowing ? "Unfollow" : "Follow"),
            onPressed: () {
              if (!viewModel.isFollowLoading) {
                if (user.isFollowing) {
                  viewModel.unfollowUser(user.id);
                } else {
                  viewModel.followUser(user.id);
                }
              }
            },
            height: 42.h,
            width: 199.w,
            color: user.isFollowing ? Colors.grey.shade300 : Colors.blue,
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: user.isFollowing ? Colors.grey.shade700 : Colors.white, 
              fontSize: 14.sp, 
              letterSpacing: -0.3
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: CustomButton(
            text: "Message",
            onPressed: () {
              // Navigate to chat with this user
              Navigator.pushNamed(context, RouteName.chatScreen, arguments: {
                'otherUserId': user.id,
                'name': '${user.firstName} ${user.lastName}',
                'img': user.profilePicture,
              });
            },
            height: 42.h,
            width: 159.w,
            color: Color(0xFFF6F6F6),
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Color(0xFF202020), fontSize: 14.sp, letterSpacing: -0.3),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomTab({required String icon, required int index}) {
    return GestureDetector(
      onTap: () => _onTabTap(index),
      child: SizedBox(
        height: 37.h,
        width: 124.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              fit: BoxFit.cover,
              height: 24.h,
              width: 24.w,
              colorFilter: ColorFilter.mode(
                _currentIndex == index ? Color(0xFF202020) : Color(0xFF696969),
                BlendMode.srcIn,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.only(top: 5.h),
              height: 1.h,
              width: _currentIndex == index ? 56.w : 0,
              color: Color(0xFF202020),
            ),
          ],
        ),
      ),
    );
  }
}