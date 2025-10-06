import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class HomeViewModel with ChangeNotifier {
  final PageController _pageController = PageController(initialPage: 1);
  PageController get pageController => _pageController;
  int _selectedIndex = 1;
int get selectedIndex=>_selectedIndex;

  void changeTab(int index){
    _selectedIndex=index;
    pageController.animateToPage(index, duration:  Duration(milliseconds: 300), curve: Curves.easeInOut,);
    notifyListeners();
  }
  void changeIndex(int index){
    _selectedIndex=index;
     notifyListeners();
  }

  void playPause(VideoPlayerController controller){
    controller.value.isPlaying ? controller.pause() : controller.play();
  notifyListeners();
  }

}
