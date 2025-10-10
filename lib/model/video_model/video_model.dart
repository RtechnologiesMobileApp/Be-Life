import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_converters.dart';

part 'video_model.freezed.dart';
part 'video_model.g.dart';

@freezed
abstract class VideoModel with _$VideoModel {
  const factory VideoModel({
    @JsonKey(includeIfNull: false) int? id,
    @JsonKey(includeIfNull: false)  int? postedBy,
    @JsonKey(includeIfNull: false)  String? uploaderProfilePicture,
    @JsonKey(includeIfNull: false)  String? uploaderName,
    @JsonKey(includeIfNull: false) int?likesCount,
    @JsonKey(includeIfNull: false)  int?SavedCount,
    @JsonKey(includeIfNull: false)   int?shareCount,
    @JsonKey(includeIfNull: false)  int?commentsCount,
    @JsonKey(includeIfNull: false) int?viewsCount,
    @JsonKey(includeIfNull: false) bool? isLiked,
    @JsonKey(includeIfNull: false) bool? isSaved,
    @JsonKey(includeIfNull: false)  @BoolFromIntConverter() bool? DownloadAllow,
    required String videoUrl,
    required String thumbnailUrl,
    required String videoGenre,
    required String ShareLink,
    required String locationTag,
    required int duration,
    required int originalAudioOwnerId,
    required String videoResolution,
    required String videoRatio,
    required String PrivacyType,
    @JsonKey(includeIfNull: false) String? place, //
    @BoolFromIntConverter() required bool isOriginalSound,
    @BoolFromIntConverter()  required bool ageRestricted,
    @JsonKey(includeIfNull: false) String? videoCaption,

  }) = _VideoModel;

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
}
