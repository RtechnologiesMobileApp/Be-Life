import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_response_model.freezed.dart';
part 'comment_response_model.g.dart';


@freezed
abstract class CommentResponseModel with _$CommentResponseModel {
  factory CommentResponseModel({
    required int id,
    required int userId,
    required int videoId,
    int? parentId,
    bool? isLiked,
    required String text,
    required int likesCount,
    required String createdAt,
    required String username,
    required String profilePicture,
    @Default([]) List<Reply> replies,
  }) = _CommentResponseModel;

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) => _$CommentResponseModelFromJson(json);
}

@freezed
abstract class Reply with _$Reply {
  factory Reply({
    required int id,
    required int userId,
    required int videoId,
    int? parentId,
    required String text,
    required int likesCount,
    required String createdAt,
    required String username,
    required String profilePicture,
  }) = _Reply;

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
}
