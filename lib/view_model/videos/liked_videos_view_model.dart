import 'dart:developer';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/cupertino.dart';

class LikedVideosViewModel with ChangeNotifier {
   LikedVideosViewModel({required this.videosRepo});
  // {
  //   getLikedVideos();
  // }

  final VideoRepo videosRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  final List<VideoModel> _likedVideos = [];
  List<VideoModel> get likedVideos=>_likedVideos;
  bool _hasFetched = false; // ✅ new flag
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }


  Future<void> getLikedVideos() async {
        if (_hasFetched) return; 
    _hasFetched = true;
    setLoading(true);

    try {
      final fetchedVideos = await videosRepo.fetchLikedVideos(id: SessionController().id!, token: SessionController().token);
      _likedVideos.clear();
      _likedVideos.addAll(fetchedVideos);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> getUserLikedVideos(int userId) async {
     if (_hasFetched) return; 
    _hasFetched = true;
    setLoading(true);
    try {
      final fetchedVideos = await videosRepo.fetchUserLikedVideos(userId: userId, token: SessionController().token);
      _likedVideos.clear();
      _likedVideos.addAll(fetchedVideos);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    debugPrint("disposed");
    super.dispose();
  }
}