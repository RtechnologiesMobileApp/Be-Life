
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
  // Note: Removed automatic reset when opening inbox tab
  // Counter will only reset when DirectMsgWidget is clicked
  notifyListeners();
}
  // 👇 increment unread message count
  void incrementUnread() {
    print("🔥 MainNavViewModel: incrementing unread count from $_unreadCount to ${_unreadCount + 1}");
    _unreadCount++;
    notifyListeners();
    print("🔥 MainNavViewModel: unread count updated to $_unreadCount");
  }

  // 👇 reset unread count to 0
  void resetUnread() {
    if (_unreadCount != 0) {
      print("🔥 MainNavViewModel: resetting unread count from $_unreadCount to 0");
      _unreadCount = 0;
      notifyListeners();
      print("🔥 MainNavViewModel: unread count reset to $_unreadCount");
    }
  }

  // 👇 For testing purposes - manually set unread count
  void setUnreadCount(int count) {
    print("🔥 MainNavViewModel: manually setting unread count to $count");
    _unreadCount = count;
    notifyListeners();
    print("🔥 MainNavViewModel: unread count set to $_unreadCount");
  }
}