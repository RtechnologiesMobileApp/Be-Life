import 'dart:developer';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/cupertino.dart';

class MyVideosViewModel with ChangeNotifier {
  MyVideosViewModel({required this.videosRepo}) {
    getMyVideos();
  }
  final VideoRepo videosRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<VideoModel> _myVideos = [];
  List<VideoModel> get myVideos => _myVideos;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> getMyVideos() async {
    setLoading(true);
    try {
      final fetchedVideos = await videosRepo.fetchMyVideos(id: SessionController().id!, token: SessionController().token);
      _myVideos.clear();
      _myVideos.addAll(fetchedVideos);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> getUserVideos(int userId) async {
    setLoading(true);
    try {
      final fetchedVideos = await videosRepo.fetchUserVideos(userId: userId, token: SessionController().token);
      _myVideos.clear();
      _myVideos.addAll(fetchedVideos);
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