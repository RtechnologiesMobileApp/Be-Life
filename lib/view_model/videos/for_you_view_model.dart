// for_you_view_model.dart
import 'dart:developer';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideosViewModel with ChangeNotifier {
  VideosViewModel({required this.videosRepo, required int index}) {
    index == 1 ? fetchForYouVideos() : fetchFollowingVideos();
  }

  final VideoRepo videosRepo;
  final PageController pageController = PageController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<VideoPlayerController> _controllers = [];
  List<VideoPlayerController> get controllers => _controllers;

  final List<VideoModel> _fetchedVideos = [];
  List<VideoModel> get fetchedVideos => _fetchedVideos;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  int _currentPage = 1;
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    pageController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    debugPrint("VideosViewModel disposed");
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

  void setCurrentIndex(int index) async {
    if (!_isDisposed && hasListeners) {
      if (index != _currentIndex) {
        if (_controllers.isNotEmpty && _controllers.length > _currentIndex) {
          _controllers[_currentIndex].pause();
        }
        _currentIndex = index;

        if (_controllers.isNotEmpty &&
            _controllers.length > _currentIndex &&
            _controllers[_currentIndex].value.isInitialized) {
          _controllers[_currentIndex].play();
        }

        notifyListeners();

        if ((_currentIndex + 1) % 5 == 0) {
          _currentPage++;
          await fetchForYouVideos();
        }
      }
    }
  }

  Future<void> fetchForYouVideos() async {
    setLoading(true);
    try {
      final newVideos = await videosRepo.fetchForYouVideos(
        id: SessionController().id!,
        currentPage: _currentPage,
      );
      final previousIndex = _currentIndex;
      final previousLength = _fetchedVideos.length;

      _fetchedVideos.addAll(newVideos);
      _initializeVideos(newVideos);

      if (previousLength > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_isDisposed && hasListeners && pageController.hasClients) {
            try {
              pageController.jumpToPage(previousIndex);
            } catch (e) {
              log("Error jumping to page: $e");
            }
          }
        });
      }
    } catch (e) {
      log(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchFollowingVideos() async {
    setLoading(true);
    try {
      final newVideos = await videosRepo.fetchFollowingVideos(
        currentPage: _currentPage,
        token: SessionController().token,
      );
      final previousIndex = _currentIndex;
      final previousLength = _fetchedVideos.length;

      _fetchedVideos.addAll(newVideos);
      _initializeVideos(newVideos);

      if (previousLength > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_isDisposed && hasListeners && pageController.hasClients) {
            try {
              pageController.jumpToPage(previousIndex);
            } catch (e) {
              log("Error jumping to page: $e");
            }
          }
        });
      }
    } catch (e) {
      log(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void _initializeVideos(List<VideoModel> newVideos) {
    for (var video in newVideos) {
      final controller =
      VideoPlayerController.networkUrl(Uri.parse(video.videoUrl));
      controller.initialize().then((_) {
        if (!_isDisposed && hasListeners) {
          notifyListeners();
        }
      });

      controller.setLooping(true);
      _controllers.add(controller);
    }

    if (_controllers.length == newVideos.length &&
        _controllers.isNotEmpty &&
        !_isDisposed &&
        hasListeners &&
        _controllers.length > _currentIndex) {
      try {
        _controllers[_currentIndex].play();
      } catch (e) {
        log("Error playing controller: $e");
      }
    }
  }

  void playPause(VideoPlayerController controller) {
    if (!_isDisposed && hasListeners) {
      controller.value.isPlaying ? controller.pause() : controller.play();
      notifyListeners();
    }
  }

  void pauseAllVideos() {
    if (!_isDisposed && _controllers.isNotEmpty) {
      for (var controller in _controllers) {
        if (controller.value.isInitialized && controller.value.isPlaying) {
          controller.pause();
        }
      }
      notifyListeners();
    }
  }
}