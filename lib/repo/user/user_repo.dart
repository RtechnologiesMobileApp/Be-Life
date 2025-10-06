import 'package:be_life_style/model/user_model/user_model.dart';
import 'package:be_life_style/model/user_model/other_user_model.dart';
import 'package:be_life_style/model/user_model/user_search_model.dart';

abstract class UserRepo{
  Future<UserModel> getUserDetails(String token);
  Future<void> updateProfile(Map<String,dynamic> data,String token);
  
  // New methods for missing features
  Future<List<UserSearchModel>> searchUsers(String query, String token);
  Future<OtherUserModel> getOtherUserProfile(int userId, String token);
  Future<void> followUser(int userId, String token);
  Future<void> unfollowUser(int userId, String token);
  Future<List<OtherUserModel>> getFollowers(int userId, String token);
  Future<List<OtherUserModel>> getFollowing(int userId, String token);
}