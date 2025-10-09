import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/view_model/videos/for_you_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../view_model/profile/profile_view_model.dart';
import 'widgets/video_player.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
        builder: (context, profileVM, _) {

      if (SessionController().id==null) {
        return const Center(child: CupertinoActivityIndicator());
      }
    return  ChangeNotifierProvider(
      create: (_) => VideosViewModel(videosRepo: getIt<VideoRepo>(), index: 1),
      child: Consumer<VideosViewModel>(
        builder: (context, vVM, _) {
          if (vVM.isLoading || vVM.fetchedVideos.isEmpty || vVM.controllers.length != vVM.fetchedVideos.length) {
            return const Center(child: CupertinoActivityIndicator());
          }
          return PageView.builder(
            controller: vVM.pageController,
            scrollDirection: Axis.vertical,
            itemCount: vVM.fetchedVideos.length,
            // onPageChanged: (index) => vVM.setCurrentIndex(index),
            onPageChanged: (index) {
  vVM.setCurrentIndex(index);
  vVM.playCurrentVideo(index);
},

            itemBuilder: (context, index) {
              return VideoPlayerWidget(
                controller: vVM.controllers[index], videoData: vVM.fetchedVideos[index],
              );
            },
          );
        },
      ),
    );});
  }
}
