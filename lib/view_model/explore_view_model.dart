 
import 'dart:developer';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/widgets.dart';

class ExploreViewModel with ChangeNotifier {
  ExploreViewModel({required this.videosRepo});

  final VideoRepo videosRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<VideoModel> _videos = [];
  List<VideoModel> get videos => _videos;
    final List<VideoModel> _fetchedVideos = [];
  List<VideoModel> get fetchedVideos => _fetchedVideos;

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void setLoading(bool val) {
    if (!_isDisposed && hasListeners) {
      _isLoading = val;
      notifyListeners();
    }
  }

   
  void _updateLikeLocal(int id) {
    if (!_isDisposed && hasListeners) {
      int index = _fetchedVideos.indexWhere((video) => video.id == id);
      if (index != -1) {
        _fetchedVideos[index] = _fetchedVideos[index].copyWith(
            likesCount: _fetchedVideos[index].isLiked == false
                ? _fetchedVideos[index].likesCount! + 1
                : _fetchedVideos[index].likesCount! - 1,
            isLiked: !_fetchedVideos[index].isLiked!);
        notifyListeners();
      }
    }
  }

  void _updateBookmark(int id) {
    if (!_isDisposed && hasListeners) {
      int index = _fetchedVideos.indexWhere((video) => video.id == id);
      if (index != -1) {
        _fetchedVideos[index] =
            _fetchedVideos[index].copyWith(isSaved: !_fetchedVideos[index].isSaved!);
        notifyListeners();
      }
    }
  }

  Future<void> toggleLike(int id) async {
    try {
      _updateLikeLocal(id);
      await videosRepo.likeVideo(id: id, token: SessionController().token);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> toggleBookmark(int id) async {
    try {
      _updateBookmark(id);
      await videosRepo.bookMarkVideo(id: id, token: SessionController().token);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> loadExploreVideos() async {
    setLoading(true);
    try {
      final fetched = await videosRepo.fetchForYouVideos(
        id: SessionController().id!,
        currentPage: 1,
      );
      _videos
        ..clear()
        ..addAll(fetched);
      notifyListeners();
    } catch (e) {
      log('Explore load error: $e');
    } finally {
      setLoading(false);
    }
  }

  void toggleFav(int index) {
    if (index < 0 || index >= _videos.length) return;
    final current = _videos[index];
    final currentlyLiked = current.isLiked ?? false;
    final currentLikes = current.likesCount ?? 0;
    _videos[index] = current.copyWith(
      isLiked: !currentlyLiked,
      likesCount: currentlyLiked ? (currentLikes - 1).clamp(0, 1 << 31) : currentLikes + 1,
    );
    notifyListeners();
  }
}

 