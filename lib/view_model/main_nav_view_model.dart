
import 'package:flutter/material.dart';


class MainNavViewModel with ChangeNotifier{
int _selectedIndex=0;
 int _unreadCount = 0;
final PageController _pageController = PageController();
int get selectedIndex=>_selectedIndex;
 int get unreadCount => _unreadCount;
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
    // 👇 Reset unread count when opening Inbox tab (index = 1)
    if (index == 1) {
      resetUnread();
    }
  notifyListeners();
}
  // 👇 increment unread message count
  void incrementUnread() {
    _unreadCount++;
    notifyListeners();
  }

  // 👇 reset unread count to 0
  void resetUnread() {
    if (_unreadCount != 0) {
      _unreadCount = 0;
      notifyListeners();
    }
  }
}