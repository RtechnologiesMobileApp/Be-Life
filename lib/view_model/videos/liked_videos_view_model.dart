// import 'dart:developer';
// import 'package:be_life_style/model/video_model/video_model.dart';
// import 'package:be_life_style/repo/video/video_repo.dart';
// import 'package:be_life_style/services/session_manager/session_controller.dart';
// import 'package:flutter/cupertino.dart';

// class LikedVideosViewModel with ChangeNotifier {
//    LikedVideosViewModel({required this.videosRepo});
//   // {
//   //   getLikedVideos();
//   // }

//   final VideoRepo videosRepo;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;


//   final List<VideoModel> _likedVideos = [];
//   List<VideoModel> get likedVideos=>_likedVideos;
//   bool _hasFetched = false; // ✅ new flag
//   void setLoading(bool val) {
//     _isLoading = val;
//     notifyListeners();
//   }

// Future<void> getLikedVideos() async {
//   if (_hasFetched) return;
//   _hasFetched = true;
//   setLoading(true);

//   try {
//     debugPrint("📌 Fetching liked videos for CURRENT USER: ${SessionController().id}");
//     final fetchedVideos = await videosRepo.fetchLikedVideos(
//       id: SessionController().id!,
//       token: SessionController().token,
//     );
//     _likedVideos
//       ..clear()
//       ..addAll(fetchedVideos);
//     notifyListeners();
//   } catch (e) {
//     log("❌ Error fetching current user liked videos: $e");
//   } finally {
//     setLoading(false);
//   }
// }

// Future<void> getUserLikedVideos(int userId) async {
//   if (_hasFetched) return;
//   _hasFetched = true;
//   setLoading(true);
//   try {
//     debugPrint("📌 Fetching liked videos for OTHER USER: $userId");
//     final fetchedVideos = await videosRepo.fetchUserLikedVideos(
//       userId: userId,
//       token: SessionController().token,
//     );
//     _likedVideos
//       ..clear()
//       ..addAll(fetchedVideos);
//     notifyListeners();
//   } catch (e) {
//     log("❌ Error fetching user liked videos: $e");
//   } finally {
//     setLoading(false);
//   }
// }


//   // Future<void> getLikedVideos() async {
//   //       if (_hasFetched) return; 
//   //   _hasFetched = true;
//   //   setLoading(true);

//   //   try {
//   //     final fetchedVideos = await videosRepo.fetchLikedVideos(id: SessionController().id!, token: SessionController().token);
//   //     _likedVideos.clear();
//   //     _likedVideos.addAll(fetchedVideos);
//   //     notifyListeners();
//   //   } catch (e) {
//   //     log(e.toString());
//   //   } finally {
//   //     setLoading(false);
//   //   }
//   // }

//   // Future<void> getUserLikedVideos(int userId) async {
//   //    if (_hasFetched) return; 
//   //   _hasFetched = true;
//   //   setLoading(true);
//   //   try {
//   //     final fetchedVideos = await videosRepo.fetchUserLikedVideos(userId: userId, token: SessionController().token);
//   //     _likedVideos.clear();
//   //     _likedVideos.addAll(fetchedVideos);
//   //     notifyListeners();
//   //   } catch (e) {
//   //     log(e.toString());
//   //   } finally {
//   //     setLoading(false);
//   //   }
//   // }

//   @override
//   void dispose() {
//     debugPrint("disposed");
//     super.dispose();
//   }
// }
import 'dart:developer';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/cupertino.dart';

class LikedVideosViewModel with ChangeNotifier {
  LikedVideosViewModel({required this.videosRepo});

  final VideoRepo videosRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<VideoModel> _likedVideos = [];
  List<VideoModel> get likedVideos => _likedVideos;

  bool _hasFetched = false;
  bool _isDisposed = false;

  void _safeNotifyListeners(){
    if(!_isDisposed){
      notifyListeners();
    }
  }

  void setLoading(bool val) {
    if(_isDisposed) return;
    _isLoading = val;
    _safeNotifyListeners();
  }

  // ✅ Fetch current user's liked videos
  Future<void> getLikedVideos() async {
    if (_hasFetched) return;
    _hasFetched = true;
    setLoading(true);

    try {
      debugPrint("📌 Fetching liked videos for CURRENT USER: ${SessionController().id}");
      final fetchedVideos = await videosRepo.fetchLikedVideos(
        id: SessionController().id!,
        token: SessionController().token,
      );
      if(_isDisposed) return;
      _likedVideos
        ..clear()
        ..addAll(fetchedVideos);
      _safeNotifyListeners();
    } catch (e) {
      log("❌ Error fetching current user liked videos: $e");
    } finally {
      setLoading(false);
    }
  }

  // ✅ Fetch liked videos for another user
  Future<void> getUserLikedVideos(int userId) async {
    if (_hasFetched) return;
    _hasFetched = true;
    setLoading(true);
    try {
      debugPrint("📌 Fetching liked videos for OTHER USER: $userId");
      final fetchedVideos = await videosRepo.fetchUserLikedVideos(
        userId: userId,
        token: SessionController().token,
      );
      if(_isDisposed) return;
      _likedVideos
        ..clear()
        ..addAll(fetchedVideos);
      _safeNotifyListeners();
    } catch (e) {
      log("❌ Error fetching user liked videos: $e");
    } finally {
      setLoading(false);
    }
  }

  // ✅ LIKE / UNLIKE toggle
  Future<void> toggleLike(int id) async {
    try {
      final index = _likedVideos.indexWhere((v) => v.id == id);
      if (index == -1) return;

      final current = _likedVideos[index];
      final newIsLiked = !(current.isLiked ?? false);
      final newLikesCount = newIsLiked
          ? (current.likesCount ?? 0) + 1
          : (current.likesCount ?? 0) - 1;

      // 🔹 Optimistic UI update
      if(_isDisposed) return;
      _likedVideos[index] = current.copyWith(
        isLiked: newIsLiked,
        likesCount: newLikesCount,
      );
      _safeNotifyListeners();

      // 🔹 API call to backend
      await videosRepo.likeVideo(
        id: id,
        token: SessionController().token,
      );
    } catch (e) {
      log("❌ toggleLike failed: $e");
    }
  }

  // ✅ SAVE / UNSAVE toggle
  Future<void> toggleBookmark(int id) async {
    try {
      final index = _likedVideos.indexWhere((v) => v.id == id);
      if (index == -1) return;

      final current = _likedVideos[index];
      final newIsSaved = !(current.isSaved ?? false);

      // 🔹 Optimistic UI update
      if(_isDisposed) return;
      _likedVideos[index] = current.copyWith(isSaved: newIsSaved);
      _safeNotifyListeners();

      // 🔹 API call to backend
      await videosRepo.bookMarkVideo(
        id: id,
        token: SessionController().token,
      );
    } catch (e) {
      log("❌ toggleBookmark failed: $e");
    }
  }

  @override
  void dispose() {
    debugPrint("LikedVideosViewModel disposed");
    _isDisposed = true;
    super.dispose();
  }
}
