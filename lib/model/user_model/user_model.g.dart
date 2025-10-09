// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: (json['id'] as num?)?.toInt() ?? -1,
  username: json['username'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String,
  dob: _fromJsonDob(json['dob'] as String),
  phoneNumber: json['phoneNumber'] as String,
  interests:
      (json['interests'] as List<dynamic>).map((e) => e as String).toList(),
  profilePicture: json['profilePicture'] as String,
  bio: json['bio'] as String?,
  password: json['password'] as String?,
  followersCount: (json['followersCount'] as num?)?.toInt(),
  followingCount: (json['followingCount'] as num?)?.toInt(),
  likesCount: (json['likesCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'dob': _toJsonDob(instance.dob),
      'phoneNumber': instance.phoneNumber,
      'interests': instance.interests,
      'profilePicture': instance.profilePicture,
      'bio': instance.bio,
      'password': instance.password,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'likesCount': instance.likesCount,
    };
