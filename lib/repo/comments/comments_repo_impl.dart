import 'package:be_life_style/config/api_endpoints.dart';
import 'package:be_life_style/data/network/base_api_services.dart';
import 'package:be_life_style/model/comment_response_model/comment_response_model.dart';
import 'package:be_life_style/repo/comments/comments_repo.dart';

class CommentsRepoImpl implements CommentsRepo{
  CommentsRepoImpl({required this.apiService});
  final BaseApiService apiService;
  @override
  Future<List<CommentResponseModel>> fetchComments({required int id,required String token})async {
   try{
 final response=    await apiService.getApi(url: "${ApiEndpoints.getComments}/$id",token: token);
 List<CommentResponseModel> comments=(response['comments']as List).map((comment)=>CommentResponseModel.fromJson(comment)).toList();
  return comments;
   }catch(e){
     rethrow;
   }
  }

  @override
  Future<void> addComment({required int id, required String token,required String text})async {
   try{
     await apiService.postApi(url: "${ApiEndpoints.addComment}/$id",token: token,data: {"text":text});
   }catch(e){
     rethrow;
   }
  }
  @override
  Future<void> likeComment({required int id, required String token})async {
   try{
     await apiService.postApi(url:"${ApiEndpoints.likeComment}/$id",token: token);
   }catch(e){
   rethrow;
   }
  }
  
}