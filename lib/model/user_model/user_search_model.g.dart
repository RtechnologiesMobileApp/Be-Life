// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSearchModel _$UserSearchModelFromJson(Map<String, dynamic> json) =>
    _UserSearchModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      profilePicture: json['profilePicture'] as String,
      isFollowing: json['isFollowing'] as bool? ?? false,
      isFollowedBy: json['isFollowedBy'] as bool? ?? false,
    );

Map<String, dynamic> _$UserSearchModelToJson(_UserSearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePicture': instance.profilePicture,
      'isFollowing': instance.isFollowing,
      'isFollowedBy': instance.isFollowedBy,
    };
