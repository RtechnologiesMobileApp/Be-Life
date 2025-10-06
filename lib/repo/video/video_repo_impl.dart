import 'dart:developer';
import 'package:be_life_style/config/api_endpoints.dart';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import '../../data/network/base_api_services.dart';

class VideoRepoImpl implements VideoRepo{
  final BaseApiService apiService;
  VideoRepoImpl({required this.apiService});

  @override
  Future<void> publishVideo({required VideoModel videoDetails,required String token}) async{
  try{
    await apiService.postApi(url: ApiEndpoints.uploadVideo,data:videoDetails.toJson(),token: token );
  }catch(e){
    rethrow;
  }
  }

  @override
  Future<List<VideoModel>> fetchForYouVideos({required int id,required int currentPage}) async{
    try{
    List<VideoModel> fetchedVideos=[];
  final response=await apiService.getApi(url: "${ApiEndpoints.fetchForYouVideos}/$id?page=$currentPage");
  if(response!=null){
     fetchedVideos = (response['videos'] as List)
         .map((video) => VideoModel.fromJson(video))
         .toList();
   }
   return fetchedVideos;
    }catch(e){
      log("error here $e");
      rethrow;
    }
  }
  @override
  Future<List<VideoModel>> fetchFollowingVideos({required int currentPage,required String token}) async{
    try{
      List<VideoModel> fetchedVideos=[];
      final response=await apiService.getApi(url: "${ApiEndpoints.fetchFollowingVideos}?page=$currentPage",token:token );
      if(response!=null){
        fetchedVideos = (response['videos'] as List)
            .map((video) => VideoModel.fromJson(video))
            .toList();
      }
      return fetchedVideos;
    }catch(e){
      log("error here $e");
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> fetchMyVideos({required int id,required String token}) async{
    try{
      List<VideoModel> fetchedVideos=[];
      final response=await apiService.getApi(url: "${ApiEndpoints.fetchUserVideos}/$id",token: token);
      if(response!=null){
        fetchedVideos = (response['videos'] as List)
            .map((video) => VideoModel.fromJson(video))
            .toList();
      }
      return fetchedVideos;
    }catch(e){
      log("error my videos $e");
      rethrow;
    }
  }
  @override
  Future<List<VideoModel>> fetchSavedVideos({required int id,required String token}) async{
    try{
      List<VideoModel> fetchedVideos=[];
      final response=await apiService.getApi(url: "${ApiEndpoints.fetchSavedVideos}/$id",token: token);
      if(response!=null){
        fetchedVideos = (response['videos'] as List)
            .map((video) => VideoModel.fromJson(video))
            .toList();
      }
      return fetchedVideos;
    }catch(e){
      log("error my videos $e");
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> fetchLikedVideos({required int id,required String token}) async{
    try{
      List<VideoModel> fetchedVideos=[];
      final response=await apiService.getApi(url: "${ApiEndpoints.fetchLikedVideos}/$id",token: token);
      if(response!=null){
        fetchedVideos = (response['videos'] as List)
            .map((video) => VideoModel.fromJson(video))
            .toList();
      }
      return fetchedVideos;
    }catch(e){
      log("error my videos $e");
      rethrow;
    }
  }
  @override
  Future<void> likeVideo({required int id, required String token})async {
    try{
      await apiService.postApi(url:"${ApiEndpoints.likeVideo}/$id",token: token);
    }catch(e){
      rethrow;
    }
  }
  @override
  Future<void> bookMarkVideo({required int id, required String token})async {
    try{
      await apiService.postApi(url:"${ApiEndpoints.bookMarkVideo}/$id",token: token);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> fetchUserVideos({required int userId,required String token}) async{
    try{
      List<VideoModel> fetchedVideos=[];
      final response=await apiService.getApi(url: "${ApiEndpoints.fetchUserVideos}/$userId",token: token);
      if(response!=null){
        fetchedVideos = (response['videos'] as List)
            .map((video) => VideoModel.fromJson(video))
            .toList();
      }
      return fetchedVideos;
    }catch(e){
      log("error fetching user videos $e");
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> fetchUserSavedVideos({required int userId,required String token}) async{
    try{
      List<VideoModel> fetchedVideos=[];
      final response=await apiService.getApi(url: "${ApiEndpoints.fetchSavedVideos}/$userId",token: token);
      if(response!=null){
        fetchedVideos = (response['videos'] as List)
            .map((video) => VideoModel.fromJson(video))
            .toList();
      }
      return fetchedVideos;
    }catch(e){
      log("error fetching user saved videos $e");
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> fetchUserLikedVideos({required int userId,required String token}) async{
    try{
      List<VideoModel> fetchedVideos=[];
      final response=await apiService.getApi(url: "${ApiEndpoints.fetchLikedVideos}/$userId",token: token);
      if(response!=null){
        fetchedVideos = (response['videos'] as List)
            .map((video) => VideoModel.fromJson(video))
            .toList();
      }
      return fetchedVideos;
    }catch(e){
      log("error fetching user liked videos $e");
      rethrow;
    }
  }
}