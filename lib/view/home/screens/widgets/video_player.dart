import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/view/home/screens/widgets/left_bar.dart';
import 'package:be_life_style/view/home/screens/widgets/right_bar.dart';
import 'package:be_life_style/view_model/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final VideoModel videoData;
  const VideoPlayerWidget({super.key, required this.controller,required this.videoData});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context,hVm,child) {
        return GestureDetector(
          onTap: () {
           hVm.playPause(controller);
             },
          child: Stack(
            fit: StackFit.expand,
            children: [
              controller.value.isInitialized
                  ? FittedBox(
                fit: BoxFit.cover, // Fullscreen like TikTok
                child: SizedBox(
                  width: controller.value.size.width,
                  height: controller.value.size.height,
                      child: GestureDetector(
                        onTap: () {
                          try { controller.setVolume(1.0); } catch (_) {}
                          context.read<HomeViewModel>().playPause(controller);
                        },
                        child: VideoPlayer(controller),
                      ),
                ),
              )
                  : Center(child: CircularProgressIndicator(color: Colors.grey,)),

              // Play/Pause Icon Overlay
              if (!controller.value.isPlaying)
                Center(
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 80),
                ),

              // Sidebar Buttons (Like, Comment, Share)
              Positioned(
                right: 0,
                bottom: 16,
                child: RightBar(videoData: videoData,)
              ),
              Positioned(
                left: 0,
                bottom: 16,
                child: LeftBar(videoData: videoData,)
              ),

            ],
          ),
        );
      }
    );
  }
}
