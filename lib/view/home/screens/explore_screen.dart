import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view_model/explore_view_model.dart';
import 'package:be_life_style/view/home/screens/widgets/right_bar.dart';
import 'package:be_life_style/view/home/screens/widgets/left_bar.dart';
import 'package:be_life_style/view_model/videos/for_you_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (_)=>ExploreViewModel(videosRepo: getIt<VideoRepo>())..loadExploreVideos(),
        child: SafeArea(
          child: Column(
            children: [
              Padding( padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical:28.0.h),
              ),
              Expanded(
                child: Consumer<ExploreViewModel>(
                  builder: (context,exVM,child) {
                    if (exVM.isLoading) {
                      return const Center(child: CupertinoActivityIndicator());
                    }
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: MasonryGridView.builder(
                        itemCount: exVM.videos.length,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 4,
                          padding: EdgeInsets.zero,
                          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,), itemBuilder: (context,index){
                            final VideoModel v = exVM.videos[index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  return _ExploreVideoPage(video: v);
                                }));
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(v.thumbnailUrl, fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(height: 6.h,),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(1000),
                                        child: Image.asset(AppImages.pp3, height: 16, width: 16, fit: BoxFit.cover),
                                      ),
                                      SizedBox(width: 6.w),
                                      Expanded(
                                        child: Text(
                                          v.uploaderName ?? v.locationTag,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h,),
                                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(onTap: (){ exVM.toggleFav(index); },
                                        child: Icon((v.isLiked ?? false)?CupertinoIcons.heart_fill:CupertinoIcons.heart,color:(v.isLiked ?? false)? Colors.red:Color(0xFF868686),size: 16,)),
                                      SizedBox(width: 3.w,),
                                      Text('${v.likesCount ?? 0}',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: Colors.black),),
                                      SizedBox(width: 8.w,),
                                      Icon(CupertinoIcons.chat_bubble,color: Color(0xFF868686),size: 16,),
                                      SizedBox(width: 3.w,),
                                      Text('${v.commentsCount ?? 0}',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: Colors.black),)
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

}

class _ExploreVideoPage extends StatelessWidget{
  const _ExploreVideoPage({required this.video});
  final VideoModel video;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 9/16,
          child: Stack(
            children: [
              // Reuse the same player UI as feed by navigating to feed would be heavy; show a simple full player here
              // Use a lightweight VideoPlayerController without view model
              _InlineVideoPlayer(url: video.videoUrl),
              Positioned(
                right: 0,
                bottom: 16,
                child: ChangeNotifierProvider(
                  create: (_) => VideosViewModel(videosRepo: getIt<VideoRepo>(), index: 1),
                  child: RightBar(videoData: video),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 16,
                child: LeftBar(videoData: video),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InlineVideoPlayer extends StatefulWidget{
  const _InlineVideoPlayer({required this.url});
  final String url;
  @override
  State<_InlineVideoPlayer> createState() => _InlineVideoPlayerState();
}

class _InlineVideoPlayerState extends State<_InlineVideoPlayer>{
  late final VideoPlayerController _controller;
  @override
  void initState(){
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_){ if(mounted){ setState((){}); _controller.setLooping(true); _controller.play(); }});
  }
  @override
  void dispose(){ _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context){
    if(!_controller.value.isInitialized){ return const Center(child: CupertinoActivityIndicator()); }
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: _controller.value.size.width, height: _controller.value.size.height, child: VideoPlayer(_controller)),
    );
  }
}
