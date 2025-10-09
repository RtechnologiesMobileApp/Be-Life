 
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/home/screens/widgets/comment_bottom_sheet.dart';
import 'package:be_life_style/view/home/screens/widgets/share_bottom_sheet.dart';
import 'package:be_life_style/view_model/explore_view_model.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:be_life_style/view_model/videos/for_you_view_model.dart';
import 'package:be_life_style/view_model/videos/liked_videos_view_model.dart';
import 'package:be_life_style/view_model/videos/my_videos_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
 

class RightBar extends StatefulWidget {
  final VideoModel videoData;

  const RightBar({super.key, required this.videoData});

  @override
  State<RightBar> createState() => _RightBarState();
}

class _RightBarState extends State<RightBar> {
  late VideoModel video;

  @override
  void initState() {
    super.initState();
    video = widget.videoData;
  }

  void toggleLikeLocal() {
    setState(() {
      video = video.copyWith(
        isLiked: !(video.isLiked ?? false),
        likesCount: (video.isLiked ?? false)
            ? (video.likesCount ?? 0) - 1
            : (video.likesCount ?? 0) + 1,
      );
    });
  }

  void toggleBookmarkLocal() {
    setState(() {
      video = video.copyWith(isSaved: !(video.isSaved ?? false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 👤 Profile Avatar
          InkWell(
            onTap: () {
              if (video.postedBy != null) {
                try {
                  context.read<VideosViewModel>().pauseAllVideos();
                } catch (_) {}
                Navigator.pushNamed(
                  context,
                  RouteName.otherUserProfileScreen,
                  arguments: {'userId': video.postedBy!},
                );
              }
            },
            child: Container(
              height: 48.w,
              width: 48.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: CachedNetworkImage(
                  imageUrl: video.uploaderProfilePicture ?? "",
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      const CupertinoActivityIndicator(color: Colors.white),
                  errorWidget: (_, __, ___) =>
                      const Icon(Icons.error, color: Colors.white),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // ❤️ Like Button
          _buildLikeButton(context),

          SizedBox(height: 22.h),

          // 💬 Comments
          Column(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: Colors.white.withValues(alpha: 0.98),
                    context: context,
                    builder: (_) => CommentBottomSheet(id: video.id!),
                  );
                },
                child: SizedBox(
                  height: 32.h,
                  width: 32.h,
                  child: SvgPicture.asset(AppImages.chatIcon),
                ),
              ),
              SizedBox(height: 3.h),
              Text(video.commentsCount.toString(),
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),

          SizedBox(height: 22.h),

          // 🔗 Share
          // 🔗 Share
// 🔗 Share
InkWell(
  onTap: () async {
    final videoUrl =
        "${dotenv.env['BASE_URL']}/videos/${video.id}"; // or use video.videoUrl if it exists

    try {
      await Share.share(
        "🎬 Check out this awesome video on Be Life Style!\n\n$videoUrl",
        subject: "Watch this video",
      );

      
    } catch (e) {
      debugPrint("❌ Failed to share video: $e");
    }
  },
  child: Column(
    children: [
      SizedBox(
        height: 32.h,
        width: 32.h,
        child: SvgPicture.asset(AppImages.shareIcon),
      ),
      SizedBox(height: 3.h),
      Text(video.shareCount.toString(),
          style: Theme.of(context).textTheme.bodyMedium),
    ],
  ),
),

          // InkWell(
          //   onTap: () {
          //     showModalBottomSheet(
          //       isScrollControlled: true,
          //       shape: const RoundedRectangleBorder(),
          //       backgroundColor: Colors.white.withValues(alpha: 0.98),
          //       context: context,
          //       builder: (_) => const ShareBottomSheet(),
          //     );
          //   },
          //   child: SizedBox(
          //     height: 32.h,
          //     width: 32.h,
          //     child: SvgPicture.asset(AppImages.shareIcon),
          //   ),
          // ),
         
         
          SizedBox(height: 3.h),
          Text(video.shareCount.toString(),
              style: Theme.of(context).textTheme.bodyMedium),

          SizedBox(height: 22.h),

          // 🔖 Bookmark
          _buildBookmarkButton(context),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // ❤️ Like Button Logic
  Widget _buildLikeButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        toggleLikeLocal(); // ✅ Local instant update

        try {
          await context.read<VideosViewModel>().toggleLike(video.id!);
        } catch (_) {
          try {
            await context.read<ExploreViewModel>().toggleLike(video.id!);
          } catch (_) {
            try {
              await context.read<MyVideosViewModel>().toggleLike(video.id!);
            } catch (_) {
              try {
                await context.read<LikedVideosViewModel>().toggleLike(video.id!);
              } catch (e) {
                debugPrint("❌ Like action failed: $e");
              }
            }
          }
        }

        // Refresh Profile info
        try {
          context.read<ProfileViewModel>().refreshUserDetails();
        } catch (_) {}
      },
      child: Column(
        children: [
          SizedBox(
            height: 32.h,
            width: 32.h,
            child: SvgPicture.asset(
              video.isLiked == true
                  ? AppImages.heartFillIcon
                  : AppImages.heartIcon,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 3.h),
          Text(video.likesCount.toString(),
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  // 🔖 Bookmark Button Logic
  Widget _buildBookmarkButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        toggleBookmarkLocal(); // ✅ Local instant update

        try {
          await context.read<VideosViewModel>().toggleBookmark(video.id!);
        } catch (_) {
          try {
            await context.read<ExploreViewModel>().toggleBookmark(video.id!);
          } catch (_) {
            try {
              await context.read<MyVideosViewModel>().toggleBookmark(video.id!);
            } catch (_) {
              try {
                await context
                    .read<LikedVideosViewModel>()
                    .toggleBookmark(video.id!);
              } catch (e) {
                debugPrint("❌ Bookmark action failed: $e");
              }
            }
          }
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 32.h,
            width: 32.h,
            child: SvgPicture.asset(
              video.isSaved == true
                  ? AppImages.bookmarkFillIcon
                  : AppImages.bookmarkIcon,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 3.h),
          Text(video.shareCount.toString(),
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
