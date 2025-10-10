 
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/home/screens/widgets/comment_bottom_sheet.dart';
import 'package:be_life_style/view_model/explore_view_model.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:be_life_style/view_model/videos/for_you_view_model.dart';
import 'package:be_life_style/view_model/videos/liked_videos_view_model.dart';
import 'package:be_life_style/view_model/videos/my_videos_view_model.dart';
import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
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
  final Future<void> Function(int videoId)? onToggleLike;
  final Future<void> Function(int videoId)? onToggleBookmark;

  const RightBar({
    super.key,
    required this.videoData,
    this.onToggleLike,
    this.onToggleBookmark,
  });

  @override
  State<RightBar> createState() => _RightBarState();
}

class _RightBarState extends State<RightBar> {
  late VideoModel video;
  String? _uploaderImageUrl;

  @override
  void initState() {
    super.initState();
    video = widget.videoData;
    _uploaderImageUrl = _resolveUploaderImageUrl(context);
    if (((_uploaderImageUrl ?? '').isEmpty) && (video.postedBy != null)) {
      _fetchUploaderProfilePicture();
    }
  }

  String _resolveUploaderImageUrl(BuildContext context) {
    String? url = video.uploaderProfilePicture;

    // Fallback to current user's profile picture if this is their upload
    if (url == null || url.isEmpty) {
      try {
        final profileVM = context.read<ProfileViewModel>();
        final currentUserId = profileVM.userDetails?.id;
        if (currentUserId != null && video.postedBy == currentUserId) {
          url = profileVM.userDetails?.profilePicture;
        }
      } catch (_) {}
    }

    // Prefix BASE_URL if backend returned a relative path
    if (url != null && url.isNotEmpty && !url.startsWith('http')) {
      final base = dotenv.env['BASE_URL'] ?? '';
      if (base.isNotEmpty) {
        if (url.startsWith('/')) return '$base$url';
        return '$base/$url';
      }
    }

    return url ?? '';
  }

  Future<void> _fetchUploaderProfilePicture() async {
    try {
      final userRepo = getIt<UserRepo>();
      final other = await userRepo.getOtherUserProfile(
        video.postedBy!,
        SessionController().token,
      );
      String? pic = other.profilePicture;
      if (pic != null && pic.isNotEmpty && !pic.startsWith('http')) {
        final base = dotenv.env['BASE_URL'] ?? '';
        if (base.isNotEmpty) {
          pic = pic.startsWith('/') ? '$base$pic' : '$base/$pic';
        }
      }
      if (mounted && (pic != null && pic.isNotEmpty)) {
        setState(() {
          _uploaderImageUrl = pic;
        });
      }
    } catch (_) {
      // ignore fallback errors
    }
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
                  imageUrl: (_uploaderImageUrl?.isNotEmpty ?? false)
                      ? _uploaderImageUrl!
                      : _resolveUploaderImageUrl(context),
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
                    builder: (_) => CommentBottomSheet(
                      id: video.id!,
                      onCommentAdded: () {
                        setState(() {
                          video = video.copyWith(
                            commentsCount: (video.commentsCount ?? 0) + 1,
                          );
                        });
                      },
                    ),
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
          if (widget.onToggleLike != null) {
            await widget.onToggleLike!(video.id!);
          } else {
            await context.read<VideosViewModel>().toggleLike(video.id!);
          }
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
          if (widget.onToggleBookmark != null) {
            await widget.onToggleBookmark!(video.id!);
          } else {
            await context.read<VideosViewModel>().toggleBookmark(video.id!);
          }
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
