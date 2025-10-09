import 'dart:developer';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class MyVideosViewModel with ChangeNotifier {
  MyVideosViewModel({required this.videosRepo}) ;
  
  
  final VideoRepo videosRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<VideoModel> _myVideos = [];
  List<VideoModel> get myVideos => _myVideos;

  bool _hasFetched = false; //  new flag
    final List<VideoModel> _fetchedVideos = [];
    bool _isDisposed = false;

@override
void dispose() {
  _isDisposed = true;
  super.dispose();
}

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

void _updateLikeLocal(int id) {
  if (!_isDisposed && hasListeners) {
    int index = _fetchedVideos.indexWhere((video) => video.id == id);
    if (index != -1) {
      _fetchedVideos[index] = _fetchedVideos[index].copyWith(
        likesCount: _fetchedVideos[index].isLiked == false
            ? _fetchedVideos[index].likesCount! + 1
            : _fetchedVideos[index].likesCount! - 1,
        isLiked: !_fetchedVideos[index].isLiked!,
      );
      notifyListeners();
    }
  }
}

void _updateBookmark(int id) {
  if (!_isDisposed && hasListeners) {
    int index = _fetchedVideos.indexWhere((video) => video.id == id);
    if (index != -1) {
      _fetchedVideos[index] = _fetchedVideos[index].copyWith(
        isSaved: !_fetchedVideos[index].isSaved!,
      );
      notifyListeners();
    }
  }
}

Future<void> toggleLike(int id) async {
  try {
    int index = myVideos.indexWhere((video) => video.id == id);
    if (index != -1) {
      myVideos[index] = myVideos[index].copyWith(
        isLiked: !myVideos[index].isLiked!,
        likesCount: myVideos[index].isLiked!
            ? myVideos[index].likesCount! - 1
            : myVideos[index].likesCount! + 1,
      );
      notifyListeners();
    }
    await videosRepo.likeVideo(id: id, token: SessionController().token);
  } catch (e) {
    debugPrint("❌ MyVideos toggleLike error: $e");
  }
}

Future<void> toggleBookmark(int id) async {
  try {
    int index = myVideos.indexWhere((video) => video.id == id);
    if (index != -1) {
      myVideos[index] = myVideos[index].copyWith(
        isSaved: !myVideos[index].isSaved!,
      );
      notifyListeners();
    }
    await videosRepo.bookMarkVideo(id: id, token: SessionController().token);
  } catch (e) {
    debugPrint("❌ MyVideos toggleBookmark error: $e");
  }
}

 


 
 void playPause(VideoPlayerController controller) {
  if (controller.value.isPlaying) {
    controller.pause();
  } else {
    controller.play();
  }
  notifyListeners();
}

  Future<void> getMyVideos() async {
      if (_hasFetched) return; // 
    _hasFetched = true;
    setLoading(true);
    try {
      final fetchedVideos = await videosRepo.fetchMyVideos(
        id: SessionController().id!,
        token: SessionController().token,
      );

      if (!hasListeners) return; // ✅ ViewModel dispose ho gaya to kuch mat karo

      _myVideos.clear();
      _myVideos.addAll(fetchedVideos);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    } finally {
       if (hasListeners) {
    setLoading(false);
  }
    }
  }

  Future<void> getUserVideos(int userId) async {
     if (_hasFetched) return; // 
    _hasFetched = true;
    setLoading(true);
    try {
      final fetchedVideos = await videosRepo.fetchUserVideos(
        userId: userId,
        token: SessionController().token,
      );
      if (!hasListeners) return;
      _myVideos.clear();
      _myVideos.addAll(fetchedVideos);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }   if (hasListeners) {
    setLoading(false);
  }
    
  }

 
}

// import 'dart:developer';
// import 'package:be_life_style/model/video_model/video_model.dart';
// import 'package:be_life_style/repo/video/video_repo.dart';
// import 'package:be_life_style/services/session_manager/session_controller.dart';
// import 'package:flutter/cupertino.dart';

// class MyVideosViewModel with ChangeNotifier {
//   MyVideosViewModel({required this.videosRepo}) {
//     // optional: you can call getMyVideos here or trigger it externally when provider is created
//     getMyVideos();
//   }
//   final VideoRepo videosRepo;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   final List<VideoModel> _myVideos = [];
//   List<VideoModel> get myVideos => _myVideos;

//   /// Safely set loading flag and notify only if there are listeners.
//   void setLoading(bool val) {
//     _isLoading = val;
//     if (hasListeners) {
//       notifyListeners();
//     }
//   }

//   Future<void> getMyVideos() async {
//     setLoading(true);
//     try {
//       log('getMyVideos: fetching for user ${SessionController().id}');
//       final fetchedVideos = await videosRepo.fetchMyVideos(
//         id: SessionController().id!,
//         token: SessionController().token,
//       );

//       // update local list
//       _myVideos
//         ..clear()
//         ..addAll(fetchedVideos);

//       // notify only if still mounted (has listeners)
//       if (hasListeners) {
//         notifyListeners();
//         log('getMyVideos: fetched ${fetchedVideos.length} videos');
//       }
//     } catch (e) {
//       log('getMyVideos error: $e');
//     } finally {
//       // safe call to setLoading (it will notify only if hasListeners)
//       setLoading(false);
//     }
//   }

//   Future<void> getUserVideos(int userId) async {
//     setLoading(true);
//     try {
//       log('getUserVideos: fetching for user $userId');
//       final fetchedVideos = await videosRepo.fetchUserVideos(
//         userId: userId,
//         token: SessionController().token,
//       );

//       _myVideos
//         ..clear()
//         ..addAll(fetchedVideos);

//       if (hasListeners) {
//         notifyListeners();
//         log('getUserVideos: fetched ${fetchedVideos.length} videos for $userId');
//       }
//     } catch (e) {
//       log('getUserVideos error: $e');
//     } finally {
//       setLoading(false);
//     }
//   }

//   @override
//   void dispose() {
//     debugPrint("MyVideosViewModel disposed");
//     super.dispose();
//   }
// }
