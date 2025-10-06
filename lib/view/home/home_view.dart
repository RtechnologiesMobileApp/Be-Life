import 'package:be_life_style/view/home/screens/explore_screen.dart';
import 'package:be_life_style/view/home/screens/following_screen.dart';
import 'package:be_life_style/view/home/screens/for_you_screen.dart';
import 'package:be_life_style/view/home/widgets/top_section.dart';
import 'package:be_life_style/view_model/main_nav_view_model.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:be_life_style/view_model/videos/for_you_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/home/home_view_model.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileViewModel>(context,listen: false).fetchUserDetails(context);
      
      // Set up callback to pause videos when leaving home tab
      try {
        final mainNavVM = Provider.of<MainNavViewModel>(context, listen: false);
        mainNavVM.setPauseVideosCallback(() {
          // Try to find and pause videos in all video view models
          try {
            final context = this.context;
            if (context.mounted) {
              // This will pause videos in the currently active video view model
              _pauseAllVideosInContext(context);
            }
          } catch (e) {
            // Ignore if context is not available
          }
        });
      } catch (e) {
        // MainNavViewModel might not be available
      }
    });
  }

  void _pauseAllVideosInContext(BuildContext context) {
    try {
      // Try to find VideosViewModel in the widget tree and pause videos
      final videosVM = Provider.of<VideosViewModel>(context, listen: false);
      videosVM.pauseAllVideos();
    } catch (e) {
      // VideosViewModel might not be available
    }
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Container(color: Colors.black,
        child: Stack(
          children: [
            Consumer<HomeViewModel>(
                builder: (context,homeVM,child) {
                  return PageView(
                    controller: homeVM.pageController,
                    onPageChanged: (index) => homeVM.changeIndex(index),
                    children: [
                      ExploreScreen(),
                      ForYouScreen(),
                      FollowingScreen(),
                    ],);
                }
            ),
            TopSection(),

          ],
        ),
      ),
    );
  }
}
