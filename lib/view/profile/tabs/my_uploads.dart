import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/view_model/videos/my_videos_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyUploads extends StatelessWidget {
  final int? userId; // If null, show logged-in user's videos, otherwise show specific user's videos
  
  const MyUploads({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyVideosViewModel(videosRepo: getIt<VideoRepo>()),
      child: Consumer<MyVideosViewModel>(
        builder: (context, mVM, _) {
          // Load videos based on userId
          if (mVM.myVideos.isEmpty && !mVM.isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (userId != null) {
                mVM.getUserVideos(userId!);
              } else {
                mVM.getMyVideos();
              }
            });
          }

    if (mVM.isLoading) {
            return const CustomLoader();
          }

          if (mVM.myVideos.isEmpty) {
            return const Center(
              child: Text(
                "No videos uploaded yet",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            );
          }
          return 
               GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: false,
                  itemCount: mVM.myVideos.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisExtent: 124.h,
                  ),
                  itemBuilder: (context, index) => CachedNetworkImage(
                    imageUrl: mVM.myVideos[index].thumbnailUrl,
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

// import 'package:be_life_style/config/locator.dart';
// import 'package:be_life_style/res/components/custom_loader.dart';
// import 'package:be_life_style/view_model/videos/my_videos_view_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// class MyUploads extends StatelessWidget {
//   final int? userId; // null => logged-in user, otherwise specific user

//   const MyUploads({super.key, this.userId});

//   @override
//   Widget build(BuildContext context) {
//     final mVM = Provider.of<MyVideosViewModel>(context, listen: true);

//     // ✅ Fetch only once (jab list empty ho)
//     if (mVM.myVideos.isEmpty && !mVM.isLoading) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (userId != null) {
//           mVM.getUserVideos(userId!);
//         } else {
//           mVM.getMyVideos();
//         }
//       });
//     }

//     return mVM.isLoading
//         ? const CustomLoader()
//         : GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: false,
//             itemCount: mVM.myVideos.length,
//             padding: EdgeInsets.zero,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 1,
//               mainAxisExtent: 124.h,
//             ),
//             itemBuilder: (context, index) => CachedNetworkImage(
//               imageUrl: mVM.myVideos[index].thumbnailUrl,
//               fit: BoxFit.cover,
//               height: 124.h,
//               width: 159.w,
//             ),
//           );
//   }
// }
