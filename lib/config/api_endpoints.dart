import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  ApiEndpoints._();
 static final String baseUrl = dotenv.env['BASE_URL']!;
  static final String signIn = "$baseUrl/users/login";
  static final String signup = "$baseUrl/users/register";
  static final String getUserDetails = "$baseUrl/users/getProfile";
  static final String updateProfile = "$baseUrl/users/updateProfile";
  static final String uploadVideo = "$baseUrl/videos/upload";
  static final String fetchForYouVideos = "$baseUrl/beLive/for-you";
  static final String fetchFollowingVideos = "$baseUrl/following/feed";
  static final String fetchUserVideos = "$baseUrl/users/getUserVideo";
  static final String fetchSavedVideos = "$baseUrl/users/saved-videos";
  static final String fetchLikedVideos = "$baseUrl/users/liked-videos";
  static final String getComments = "$baseUrl/videos/get-all-comments";
  static final String addComment = "$baseUrl/videos/comment";
  static final String likeComment = "$baseUrl/videos/like-comment";
  static final String likeVideo = "$baseUrl/videos/like";
  static final String bookMarkVideo = "$baseUrl/videos/save";
  static final String fetchChatList = "$baseUrl/messages/chat-room";
  static final String fetchChatMessages = "$baseUrl/messages/getChatHistory";
  
  // New endpoints for missing features
  static final String searchUsers = "$baseUrl/users/search";
  static final String getUserProfile = "$baseUrl/users/profile";
  static final String followUser = "$baseUrl/users/follow";
  static final String unfollowUser = "$baseUrl/users/unfollow";
  static final String getFollowers = "$baseUrl/users/followers";
  static final String getFollowing = "$baseUrl/users/following";

  // new endpoints for otp
  static final String sendOtp = "$baseUrl/otp/sendOtp";
  static final String verifyOtp = "$baseUrl/otp/verifyOtp";
}
