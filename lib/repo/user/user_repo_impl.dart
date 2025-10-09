import 'dart:developer';
import 'package:be_life_style/config/api_endpoints.dart';
import 'package:be_life_style/data/network/base_api_services.dart';
import 'package:be_life_style/model/user_model/user_model.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/model/user_model/other_user_model.dart';
import 'package:be_life_style/model/user_model/user_search_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final BaseApiService apiService;
  UserRepoImpl({required this.apiService});

  @override
  Future<UserModel> getUserDetails(String token) async {
    try {
      final response = await apiService.getApi(
        url: ApiEndpoints.getUserDetails,
        token: token,
      );
      log("✅ getUserDetails response: ${response['data']}");
      try {
        final data = response['data'];
        if (data is Map && data.containsKey('bio')) {
          SessionController().bio = data['bio']?.toString();
        }
      } catch (e) {
        log('⚠️ Could not parse bio from getUserDetails: $e');
      }
      return UserModel.fromJson(response['data']);
    } catch (e) {
      log("❌ Error in getUserDetails: $e");
      rethrow;
    }
  }

  @override
  Future<void> updateProfile(Map<String, dynamic> data, String token) async {
    try {
      final Map<String, dynamic> safeLogData = Map<String, dynamic>.from(data);
      if (safeLogData.containsKey('password')) {
        final String pwd = safeLogData['password']?.toString() ?? '';
        safeLogData['password'] = '*** (len=' + pwd.length.toString() + ')';
      }
      log('[UserRepoImpl.updateProfile] URL: ' + ApiEndpoints.updateProfile);
      log(
        '[UserRepoImpl.updateProfile] token prefix: ' +
            (token.isNotEmpty
                ? token.substring(0, token.length.clamp(0, 12)) + '...'
                : '(empty)'),
      );
      log('[UserRepoImpl.updateProfile] payload: ' + safeLogData.toString());
      await apiService.putApi(
        url: ApiEndpoints.updateProfile,
        data: data,
        token: token,
      );
      log("✅ updateProfile success");
    } catch (e) {
      log("❌ Error in updateProfile: $e");
      rethrow;
    }
  }

  @override
  Future<List<UserSearchModel>> searchUsers(String query, String token) async {
    try {
      log("🔍 Searching users with query: $query");
      final response = await apiService.getApi(
        url: "${ApiEndpoints.searchUsers}?username=$query",
        token: token,
      );
      log("✅ searchUsers response: $response");

      if (response != null && response['data'] != null) {
        final users =
            (response['data'] as List)
                .map((user) => UserSearchModel.fromJson(user))
                .toList();
        log("🔎 Found ${users.length} users");
        return users;
      }
      log("⚠️ No users found or invalid format");
      return [];
    } catch (e) {
      log("❌ Error in searchUsers: $e");
      rethrow;
    }
  }

  @override
  Future<OtherUserModel> getOtherUserProfile(int userId, String token) async {
    try {
      log("📌 Fetching profile of userId: $userId");
      final response = await apiService.getApi(
        url: "${ApiEndpoints.getUserProfile}/$userId",
        token: token,
      );
      log("✅ getOtherUserProfile response: $response");
      return OtherUserModel.fromJson(response['data']);
    } catch (e) {
      log("❌ Error in getOtherUserProfile: $e");
      rethrow;
    }
  }

  @override
  Future<void> followUser(int userId, String token) async {
    try {
      log("➡️ Calling FOLLOW API for userId: $userId");
      log("🔑 Token: ${token.substring(0, 15)}...");

      final response = await apiService.postApi(
        url: ApiEndpoints.followUser,
        token: token,
        data: {"followingId": userId},
      );

      log("✅ followUser success, response: $response");
    } catch (e) {
      log("❌ Error in followUser: $e");
      rethrow;
    }
  }

  @override
  Future<void> unfollowUser(int userId, String token) async {
    try {
      log("➡️ Calling UNFOLLOW API for userId: $userId");
      log("🔑 Token: ${token.substring(0, 15)}...");

      final response = await apiService.postApi(
        url: ApiEndpoints.unfollowUser, // sirf /unfollow
        token: token,
        data: {
          "followingId": userId, // ✅ body me
        },
      );

      log("✅ unfollowUser success, response: $response");
    } catch (e) {
      log("❌ Error in unfollowUser: $e");
      rethrow;
    }
  }

  @override
  Future<List<OtherUserModel>> getFollowers(int userId, String token) async {
    try {
      log("📌 Fetching followers of userId: $userId");
      final response = await apiService.getApi(
        url: "${ApiEndpoints.getFollowers}/$userId",
        token: token,
      );
      log("✅ getFollowers response: $response");

      if (response != null && response['data'] != null) {
        return (response['data'] as List)
            .map((user) => OtherUserModel.fromJson(user))
            .toList();
      }
      log("⚠️ No followers found");
      return [];
    } catch (e) {
      log("❌ Error in getFollowers: $e");
      rethrow;
    }
  }

  @override
  Future<List<OtherUserModel>> getFollowing(int userId, String token) async {
    try {
      log("📌 Fetching following of userId: $userId");
      final response = await apiService.getApi(
        url: "${ApiEndpoints.getFollowing}/$userId",
        token: token,
      );
      log("✅ getFollowing response: $response");

      if (response != null && response['data'] != null) {
        return (response['data'] as List)
            .map((user) => OtherUserModel.fromJson(user))
            .toList();
      }
      log("⚠️ No following found");
      return [];
    } catch (e) {
      log("❌ Error in getFollowing: $e");
      rethrow;
    }
  }
}
