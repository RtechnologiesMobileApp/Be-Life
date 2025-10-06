
import 'package:flutter/material.dart';


class MainNavViewModel with ChangeNotifier{
int _selectedIndex=0;
final PageController _pageController = PageController();
int get selectedIndex=>_selectedIndex;
PageController get pageController => _pageController;

// Callback to pause videos when leaving home
VoidCallback? _pauseVideosCallback;

void setPauseVideosCallback(VoidCallback callback) {
  _pauseVideosCallback = callback;
}

void changeIndex(int index){
  // If leaving home tab (index 0), pause videos
  if (_selectedIndex == 0 && index != 0 && _pauseVideosCallback != null) {
    _pauseVideosCallback!();
  }
  
  _selectedIndex=index;
  _pageController.jumpToPage(index);
  notifyListeners();
}
}