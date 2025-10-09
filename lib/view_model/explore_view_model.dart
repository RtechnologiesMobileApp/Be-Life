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

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
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