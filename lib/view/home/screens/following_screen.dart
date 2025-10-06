import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/view_model/videos/for_you_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/profile/profile_view_model.dart';
import 'widgets/video_player.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
        builder: (context, profileVM, _) {

          if (SessionController().id==null) {
            return const Center(child: CupertinoActivityIndicator());
          }
          return  ChangeNotifierProvider(
            create: (_) => VideosViewModel(videosRepo: getIt<VideoRepo>(), index: 2),
            child: Consumer<VideosViewModel>(
              builder: (context, vVM, _) {
                if (vVM.isLoading ||  vVM.controllers.length != vVM.fetchedVideos.length) {
                  return const Center(child: CupertinoActivityIndicator());
                }
              else  if(vVM.fetchedVideos.isEmpty){
                  return Center(child: Text("You are not following anyone",style: Theme.of(context).textTheme.bodyMedium,),);
                }
                return PageView.builder(
                  controller: vVM.pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: vVM.fetchedVideos.length,
                  onPageChanged: (index) => vVM.setCurrentIndex(index),
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
