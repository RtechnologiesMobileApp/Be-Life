import 'dart:developer';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/cupertino.dart';

class SavedVideosViewModel with ChangeNotifier {
  SavedVideosViewModel({required this.videosRepo});
  
  
  //  {
  //   getSavedVideos();
  // }

  final VideoRepo videosRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  final List<VideoModel> _savedVideos = [];
  List<VideoModel> get savedVideos=>_savedVideos;
    bool _hasFetched = false;
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }


  Future<void> getSavedVideos() async {
      if (_hasFetched) return; 
    _hasFetched = true;

    setLoading(true);
    try {
      final fetchedVideos = await videosRepo.fetchSavedVideos(id: SessionController().id!, token: SessionController().token);
      _savedVideos.clear();
      _savedVideos.addAll(fetchedVideos);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> getUserSavedVideos(int userId) async {
      if (_hasFetched) return; 
    _hasFetched = true;
    setLoading(true);
    try {
      final fetchedVideos = await videosRepo.fetchUserSavedVideos(userId: userId, token: SessionController().token);
      _savedVideos.clear();
      _savedVideos.addAll(fetchedVideos);
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