import 'dart:developer';
import 'package:be_life_style/model/user_model/other_user_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/material.dart';

class OtherUserProfileViewModel with ChangeNotifier {
  final UserRepo userRepo;
  
  OtherUserProfileViewModel({required this.userRepo});

  OtherUserModel? _userProfile;
  OtherUserModel? get userProfile => _userProfile;
  
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

  Future<void> fetchUserProfile(int userId) async {
    setLoading(true);
    try {
      final profile = await userRepo.getOtherUserProfile(userId, SessionController().token);
      _userProfile = profile;
      log('User profile loaded: ${profile.firstName} ${profile.lastName}, isFollowing: ${profile.isFollowing}');
      notifyListeners();
    } catch (e) {
      log('Error getting user profile: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> followUser(int userId) async {
    if (_userProfile == null) return;
    
    setFollowLoading(true);
    try {
      await userRepo.followUser(userId, SessionController().token);
      // Update the follow status and increment follower count
      final currentFollowers = _userProfile!.followersCount ?? 0;
      _userProfile = _userProfile!.copyWith(
        isFollowing: true,
        followersCount: currentFollowers + 1,
      );
      log('Successfully followed user: ${_userProfile!.firstName}');
      notifyListeners();
    } catch (e) {
      log('Error following user: $e');
    } finally {
      setFollowLoading(false);
    }
  }

  Future<void> unfollowUser(int userId) async {
    if (_userProfile == null) return;
    
    setFollowLoading(true);
    try {
      await userRepo.unfollowUser(userId, SessionController().token);
      // Update the follow status and decrement follower count
      final currentFollowers = _userProfile!.followersCount ?? 0;
      _userProfile = _userProfile!.copyWith(
        isFollowing: false,
        followersCount: currentFollowers > 0 ? currentFollowers - 1 : 0,
      );
      log('Successfully unfollowed user: ${_userProfile!.firstName}');
      notifyListeners();
    } catch (e) {
      log('Error unfollowing user: $e');
    } finally {
      setFollowLoading(false);
    }
  }

  void clearProfile() {
    _userProfile = null;
    notifyListeners();
  }
}
