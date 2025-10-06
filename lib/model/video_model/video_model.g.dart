// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => _VideoModel(
  id: (json['id'] as num?)?.toInt(),
  postedBy: (json['postedBy'] as num?)?.toInt(),
  uploaderProfilePicture: json['uploaderProfilePicture'] as String?,
  uploaderName: json['uploaderName'] as String?,
  likesCount: (json['likesCount'] as num?)?.toInt(),
  SavedCount: (json['SavedCount'] as num?)?.toInt(),
  shareCount: (json['shareCount'] as num?)?.toInt(),
  commentsCount: (json['commentsCount'] as num?)?.toInt(),
  viewsCount: (json['viewsCount'] as num?)?.toInt(),
  isLiked: json['isLiked'] as bool?,
  isSaved: json['isSaved'] as bool?,
  DownloadAllow: const BoolFromIntConverter().fromJson(json['DownloadAllow']),
  videoUrl: json['videoUrl'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String,
  videoGenre: json['videoGenre'] as String,
  ShareLink: json['ShareLink'] as String,
  locationTag: json['locationTag'] as String,
  duration: (json['duration'] as num).toInt(),
  originalAudioOwnerId: (json['originalAudioOwnerId'] as num).toInt(),
  videoResolution: json['videoResolution'] as String,
  videoRatio: json['videoRatio'] as String,
  PrivacyType: json['PrivacyType'] as String,
  isOriginalSound: const BoolFromIntConverter().fromJson(
    json['isOriginalSound'],
  ),
  ageRestricted: const BoolFromIntConverter().fromJson(json['ageRestricted']),
  videoCaption: json['videoCaption'] as String?,
);

Map<String, dynamic> _$VideoModelToJson(
  _VideoModel instance,
) => <String, dynamic>{
  if (instance.id case final value?) 'id': value,
  if (instance.postedBy case final value?) 'postedBy': value,
  if (instance.uploaderProfilePicture case final value?)
    'uploaderProfilePicture': value,
  if (instance.uploaderName case final value?) 'uploaderName': value,
  if (instance.likesCount case final value?) 'likesCount': value,
  if (instance.SavedCount case final value?) 'SavedCount': value,
  if (instance.shareCount case final value?) 'shareCount': value,
  if (instance.commentsCount case final value?) 'commentsCount': value,
  if (instance.viewsCount case final value?) 'viewsCount': value,
  if (instance.isLiked case final value?) 'isLiked': value,
  if (instance.isSaved case final value?) 'isSaved': value,
  if (_$JsonConverterToJson<dynamic, bool>(
        instance.DownloadAllow,
        const BoolFromIntConverter().toJson,
      )
      case final value?)
    'DownloadAllow': value,
  'videoUrl': instance.videoUrl,
  'thumbnailUrl': instance.thumbnailUrl,
  'videoGenre': instance.videoGenre,
  'ShareLink': instance.ShareLink,
  'locationTag': instance.locationTag,
  'duration': instance.duration,
  'originalAudioOwnerId': instance.originalAudioOwnerId,
  'videoResolution': instance.videoResolution,
  'videoRatio': instance.videoRatio,
  'PrivacyType': instance.PrivacyType,
  'isOriginalSound': const BoolFromIntConverter().toJson(
    instance.isOriginalSound,
  ),
  'ageRestricted': const BoolFromIntConverter().toJson(instance.ageRestricted),
  if (instance.videoCaption case final value?) 'videoCaption': value,
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
