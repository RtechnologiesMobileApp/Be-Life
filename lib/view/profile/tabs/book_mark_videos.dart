import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/view/profile/screens/my_upload_video_player.dart';
import 'package:be_life_style/view_model/videos/saved_videos_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../config/theme/app_colors.dart';

class BookMarkedVideos extends StatelessWidget {
  final int? userId; // If null, show logged-in user's saved videos, otherwise show specific user's saved videos
  
  const BookMarkedVideos({super.key, this.userId});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SavedVideosViewModel(videosRepo: getIt<VideoRepo>()),
      child: Consumer<SavedVideosViewModel>(
        builder: (context, mVM, _) {
          // Load videos based on userId
      if (mVM.savedVideos.isEmpty && !mVM.isLoading) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final savedVM = context.read<SavedVideosViewModel>();
    final isCurrentUser = userId == null;

    if (isCurrentUser) {
      debugPrint("📌 Fetching SAVED videos for CURRENT USER: ${SessionController().id}");
      savedVM.getSavedVideos();
    } else {
      debugPrint("📌 Fetching SAVED videos for OTHER USER: $userId");
      savedVM.getUserSavedVideos(userId!);
    }
  });
}


          return mVM.isLoading
              ? const CustomLoader()
              : mVM.savedVideos.isEmpty
                  ? Center(
                      child: Text(
                        userId != null 
                            ? "This user hasn't saved any videos yet"
                            : "You don't have any saved videos",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    )
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: mVM.savedVideos.length,
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisExtent: 124.h,
                      ),
                       itemBuilder: (context, index) {
              final video = mVM.savedVideos[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MyUploadedVideoPlayerScreen(videoData: video),
                    ),
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: video.thumbnailUrl,
                  fit: BoxFit.cover,
                  height: 124.h,
                  width: 159.w,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

 