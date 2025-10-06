// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentResponseModel _$CommentResponseModelFromJson(
  Map<String, dynamic> json,
) => _CommentResponseModel(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  videoId: (json['videoId'] as num).toInt(),
  parentId: (json['parentId'] as num?)?.toInt(),
  isLiked: json['isLiked'] as bool?,
  text: json['text'] as String,
  likesCount: (json['likesCount'] as num).toInt(),
  createdAt: json['createdAt'] as String,
  username: json['username'] as String,
  profilePicture: json['profilePicture'] as String,
  replies:
      (json['replies'] as List<dynamic>?)
          ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CommentResponseModelToJson(
  _CommentResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'videoId': instance.videoId,
  'parentId': instance.parentId,
  'isLiked': instance.isLiked,
  'text': instance.text,
  'likesCount': instance.likesCount,
  'createdAt': instance.createdAt,
  'username': instance.username,
  'profilePicture': instance.profilePicture,
  'replies': instance.replies,
};

_Reply _$ReplyFromJson(Map<String, dynamic> json) => _Reply(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  videoId: (json['videoId'] as num).toInt(),
  parentId: (json['parentId'] as num?)?.toInt(),
  text: json['text'] as String,
  likesCount: (json['likesCount'] as num).toInt(),
  createdAt: json['createdAt'] as String,
  username: json['username'] as String,
  profilePicture: json['profilePicture'] as String,
);

Map<String, dynamic> _$ReplyToJson(_Reply instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'videoId': instance.videoId,
  'parentId': instance.parentId,
  'text': instance.text,
  'likesCount': instance.likesCount,
  'createdAt': instance.createdAt,
  'username': instance.username,
  'profilePicture': instance.profilePicture,
};
