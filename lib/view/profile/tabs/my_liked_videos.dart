import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/config/theme/app_colors.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/view_model/videos/liked_videos_view_model.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyLikedVideos extends StatefulWidget {
  final int? userId; // If null, show logged-in user's liked videos, otherwise show specific user's liked videos
  
  const MyLikedVideos({super.key, this.userId});
  
  @override
  State<MyLikedVideos> createState() => _MyLikedVideosState();
}

class _MyLikedVideosState extends State<MyLikedVideos> {
  @override
  void initState() {
    super.initState();
    // Refresh profile data when this tab is loaded (only for logged-in user)
    if (widget.userId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final profileVM = context.read<ProfileViewModel>();
        profileVM.refreshUserDetails();
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LikedVideosViewModel(videosRepo: getIt<VideoRepo>()),
      child: Consumer<LikedVideosViewModel>(
        builder: (context, mVM, _) {
          // Load videos based on userId
          if (mVM.likedVideos.isEmpty && !mVM.isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (widget.userId != null) {
                mVM.getUserLikedVideos(widget.userId!);
              } else {
                mVM.getLikedVideos();
              }
            });
          }

          return mVM.isLoading
              ? const CustomLoader()
              : mVM.likedVideos.isEmpty
                  ? Center(
                      child: Text(
                        widget.userId != null 
                            ? "This user hasn't liked any videos yet"
                            : "You don't like any videos",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    )
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: mVM.likedVideos.length,
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisExtent: 124.h,
                      ),
                      itemBuilder: (context, index) => CachedNetworkImage(
                        imageUrl: mVM.likedVideos[index].thumbnailUrl,
                        fit: BoxFit.cover,
                        height: 124.h,
                        width: 159.w,
                      ),
                    );
        },
      ),
    );
  }
}
