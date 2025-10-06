import '../../model/video_model/video_model.dart';

abstract class VideoRepo{
Future<void> publishVideo({required VideoModel videoDetails,required String token});
Future<List<VideoModel>> fetchForYouVideos({required int id,required int currentPage});
Future<List<VideoModel>> fetchFollowingVideos({required int currentPage,required String token});
Future<List<VideoModel>> fetchMyVideos({required int id,required String token});
Future<List<VideoModel>> fetchSavedVideos({required int id,required String token});
Future<List<VideoModel>> fetchLikedVideos({required int id,required String token});
Future<List<VideoModel>> fetchUserVideos({required int userId,required String token});
Future<List<VideoModel>> fetchUserSavedVideos({required int userId,required String token});
Future<List<VideoModel>> fetchUserLikedVideos({required int userId,required String token});
Future<void> likeVideo({required int id, required String token});
Future<void> bookMarkVideo({required int id, required String token});
}
