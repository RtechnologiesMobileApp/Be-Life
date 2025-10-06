import 'package:be_life_style/config/api_endpoints.dart';
import 'package:be_life_style/data/network/base_api_services.dart';
import 'package:be_life_style/model/user_model/user_model.dart';
import 'package:be_life_style/model/user_model/other_user_model.dart';
import 'package:be_life_style/model/user_model/user_search_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';

class UserRepoImpl implements UserRepo{
  final BaseApiService apiService;
  UserRepoImpl({required this.apiService});
  @override
  Future<UserModel> getUserDetails(String token) async{
   try{
    final response= await apiService.getApi(url: ApiEndpoints.getUserDetails,token: token);
   print(response['data']);
   return UserModel.fromJson(response['data']);
   }catch(e){
     rethrow;
   }
  }

  @override
  Future<void> updateProfile(Map<String,dynamic>data,String token) async{
    try{
     await apiService.putApi(url: ApiEndpoints.updateProfile,data:data,token: token);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<UserSearchModel>> searchUsers(String query, String token) async {
    try {
      print('Searching for users with query: $query');
      print('Search URL: ${ApiEndpoints.searchUsers}?username=$query');
      print('Token: ${token.substring(0, 10)}...');
      
      // Use the correct parameter name that the backend expects
      final response = await apiService.getApi(
        url: "${ApiEndpoints.searchUsers}?username=$query",
        token: token,
      );
      print('Search response: $response');
      
      if (response != null && response['data'] != null) {
        final users = (response['data'] as List)
            .map((user) => UserSearchModel.fromJson(user))
            .toList();
        print('Found ${users.length} users');
        return users;
      }
      print('No users found or invalid response format');
      return [];
    } catch (e) {
      print('Error in searchUsers: $e');
      print('Error type: ${e.runtimeType}');
      rethrow;
    }
  }

  @override
  Future<OtherUserModel> getOtherUserProfile(int userId, String token) async {
    try {
      final response = await apiService.getApi(
        url: "${ApiEndpoints.getUserProfile}/$userId",
        token: token,
      );
      return OtherUserModel.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> followUser(int userId, String token) async {
    try {
      await apiService.postApi(
        url: "${ApiEndpoints.followUser}/$userId",
        token: token,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> unfollowUser(int userId, String token) async {
    try {
      await apiService.deleteApi(
        url: "${ApiEndpoints.unfollowUser}/$userId",
        token: token,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<OtherUserModel>> getFollowers(int userId, String token) async {
    try {
      final response = await apiService.getApi(
        url: "${ApiEndpoints.getFollowers}/$userId",
        token: token,
      );
      if (response != null && response['followers'] != null) {
        return (response['followers'] as List)
            .map((user) => OtherUserModel.fromJson(user))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<OtherUserModel>> getFollowing(int userId, String token) async {
    try {
      final response = await apiService.getApi(
        url: "${ApiEndpoints.getFollowing}/$userId",
        token: token,
      );
      if (response != null && response['following'] != null) {
        return (response['following'] as List)
            .map((user) => OtherUserModel.fromJson(user))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}