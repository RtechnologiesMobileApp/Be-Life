import 'package:be_life_style/model/comment_response_model/comment_response_model.dart';

abstract class CommentsRepo{
  Future<List<CommentResponseModel>> fetchComments({required int id,required String token});
  Future<void> addComment({required int id,required String token,required String text});
  Future<void> likeComment({required int id,required String token});
}