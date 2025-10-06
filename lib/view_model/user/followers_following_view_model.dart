import 'dart:developer';
import 'package:be_life_style/model/user_model/other_user_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/material.dart';

class FollowersFollowingViewModel with ChangeNotifier {
  final UserRepo userRepo;
  
  FollowersFollowingViewModel({required this.userRepo});

  final List<OtherUserModel> _followers = [];
  List<OtherUserModel> get followers => _followers;
  
  final List<OtherUserModel> _following = [];
  List<OtherUserModel> get following => _following;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  bool _isFollowLoading = false;
  bool get isFollowLoading => _isFollowLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setFollowLoading(bool value) {
    _isFollowLoading = value;
    notifyListeners();
  }

  Future<void> getFollowers(int userId) async {
    setLoading(true);
    try {
      final results = await userRepo.getFollowers(userId, SessionController().token);
      _followers.clear();
      _followers.addAll(results);
      notifyListeners();
    } catch (e) {
      log('Error getting followers: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> getFollowing(int userId) async {
    setLoading(true);
    try {
      final results = await userRepo.getFollowing(userId, SessionController().token);
      _following.clear();
      _following.addAll(results);
      notifyListeners();
    } catch (e) {
      log('Error getting following: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> followUser(int userId) async {
    setFollowLoading(true);
    try {
      await userRepo.followUser(userId, SessionController().token);
      // Update local state
      _updateFollowStatus(userId, true);
      notifyListeners();
    } catch (e) {
      log('Error following user: $e');
    } finally {
      setFollowLoading(false);
    }
  }

  Future<void> unfollowUser(int userId) async {
    setFollowLoading(true);
    try {
      await userRepo.unfollowUser(userId, SessionController().token);
      // Update local state
      _updateFollowStatus(userId, false);
      notifyListeners();
    } catch (e) {
      log('Error unfollowing user: $e');
    } finally {
      setFollowLoading(false);
    }
  }

  void _updateFollowStatus(int userId, bool isFollowing) {
    // Update in followers list
    final followerIndex = _followers.indexWhere((user) => user.id == userId);
    if (followerIndex != -1) {
      _followers[followerIndex] = _followers[followerIndex].copyWith(isFollowing: isFollowing);
    }
    
    // Update in following list
    final followingIndex = _following.indexWhere((user) => user.id == userId);
    if (followingIndex != -1) {
      _following[followingIndex] = _following[followingIndex].copyWith(isFollowing: isFollowing);
    }
  }

  void clearLists() {
    _followers.clear();
    _following.clear();
    notifyListeners();
  }
}
