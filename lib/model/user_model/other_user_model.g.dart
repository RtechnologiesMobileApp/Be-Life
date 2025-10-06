// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OtherUserModel _$OtherUserModelFromJson(Map<String, dynamic> json) =>
    _OtherUserModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String,
      interests:
          (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
      followersCount: (json['followersCount'] as num?)?.toInt(),
      followingCount: (json['followingCount'] as num?)?.toInt(),
      likesCount: (json['likesCount'] as num?)?.toInt(),
      isFollowing: json['isFollowing'] as bool? ?? false,
      isFollowedBy: json['isFollowedBy'] as bool? ?? false,
    );

Map<String, dynamic> _$OtherUserModelToJson(_OtherUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'interests': instance.interests,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'likesCount': instance.likesCount,
      'isFollowing': instance.isFollowing,
      'isFollowedBy': instance.isFollowedBy,
    };
