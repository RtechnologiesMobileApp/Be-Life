import 'dart:developer';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/cupertino.dart';

class MyVideosViewModel with ChangeNotifier {
  MyVideosViewModel({required this.videosRepo}) ;
  
  
  final VideoRepo videosRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<VideoModel> _myVideos = [];
  List<VideoModel> get myVideos => _myVideos;

  bool _hasFetched = false; //  new flag
  void setLoading(bool val) {
    _isLoading = val;
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

  @override
  void dispose() {
    debugPrint("disposed");
    super.dispose();
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
