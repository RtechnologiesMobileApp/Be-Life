 


import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/view/home/screens/widgets/left_bar.dart';
import 'package:be_life_style/view/home/screens/widgets/right_bar.dart';
import 'package:be_life_style/view_model/videos/my_videos_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class MyUploadedVideoPlayerScreen extends StatefulWidget {
  final VideoModel videoData;
  const MyUploadedVideoPlayerScreen({super.key, required this.videoData});

  @override
  State<MyUploadedVideoPlayerScreen> createState() =>
      _MyUploadedVideoPlayerScreenState();
}

class _MyUploadedVideoPlayerScreenState
    extends State<MyUploadedVideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoData.videoUrl ?? ''),
    )
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _isInitialized = true);
          _controller
            ..setLooping(true)
            ..setVolume(1.0)
            ..play();
        }
      }).catchError((error) {
        debugPrint('Error initializing video: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyVideosViewModel(videosRepo: getIt<VideoRepo>()
      ),
      
      
      child: Consumer<MyVideosViewModel>(
        builder: (context, myVideosVM, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              alignment: Alignment.center,
              children: [
                // 🎥 Video Player with tap-to-play/pause
                if (_isInitialized)
                  GestureDetector(
                    onTap: () {
                      context.read<MyVideosViewModel>().playPause(_controller);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        if (!_controller.value.isPlaying)
                          const Icon(Icons.play_arrow,
                              color: Colors.white, size: 80),
                      ],
                    ),
                  )
                else
                  const Center(
                      child: CircularProgressIndicator(color: Colors.white)),

                // ❤️ Right Bar (like/share/bookmark)
                Positioned(
                  right: 10,
                  bottom: 80,
                 // child: RightBar(videoData: widget.videoData,   viewModel: myVideosVM),
                   child: RightBar(videoData: widget.videoData,  ),
                ),

                // 👈 Left Bar
                Positioned(
                  left: 0,
                  bottom: 16,
                  child: LeftBar(videoData: widget.videoData),
                ),

                // ⬅️ Back Button
                Positioned(
                  left: 16,
                  top: 50,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
 
 