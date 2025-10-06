// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoModel {

@JsonKey(includeIfNull: false) int? get id;@JsonKey(includeIfNull: false) int? get postedBy;@JsonKey(includeIfNull: false) String? get uploaderProfilePicture;@JsonKey(includeIfNull: false) String? get uploaderName;@JsonKey(includeIfNull: false) int? get likesCount;@JsonKey(includeIfNull: false) int? get SavedCount;@JsonKey(includeIfNull: false) int? get shareCount;@JsonKey(includeIfNull: false) int? get commentsCount;@JsonKey(includeIfNull: false) int? get viewsCount;@JsonKey(includeIfNull: false) bool? get isLiked;@JsonKey(includeIfNull: false) bool? get isSaved;@JsonKey(includeIfNull: false)@BoolFromIntConverter() bool? get DownloadAllow; String get videoUrl; String get thumbnailUrl; String get videoGenre; String get ShareLink; String get locationTag; int get duration; int get originalAudioOwnerId; String get videoResolution; String get videoRatio; String get PrivacyType;@BoolFromIntConverter() bool get isOriginalSound;@BoolFromIntConverter() bool get ageRestricted;@JsonKey(includeIfNull: false) String? get videoCaption;
/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoModelCopyWith<VideoModel> get copyWith => _$VideoModelCopyWithImpl<VideoModel>(this as VideoModel, _$identity);

  /// Serializes this VideoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.postedBy, postedBy) || other.postedBy == postedBy)&&(identical(other.uploaderProfilePicture, uploaderProfilePicture) || other.uploaderProfilePicture == uploaderProfilePicture)&&(identical(other.uploaderName, uploaderName) || other.uploaderName == uploaderName)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.SavedCount, SavedCount) || other.SavedCount == SavedCount)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.viewsCount, viewsCount) || other.viewsCount == viewsCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved)&&(identical(other.DownloadAllow, DownloadAllow) || other.DownloadAllow == DownloadAllow)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.videoGenre, videoGenre) || other.videoGenre == videoGenre)&&(identical(other.ShareLink, ShareLink) || other.ShareLink == ShareLink)&&(identical(other.locationTag, locationTag) || other.locationTag == locationTag)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.originalAudioOwnerId, originalAudioOwnerId) || other.originalAudioOwnerId == originalAudioOwnerId)&&(identical(other.videoResolution, videoResolution) || other.videoResolution == videoResolution)&&(identical(other.videoRatio, videoRatio) || other.videoRatio == videoRatio)&&(identical(other.PrivacyType, PrivacyType) || other.PrivacyType == PrivacyType)&&(identical(other.isOriginalSound, isOriginalSound) || other.isOriginalSound == isOriginalSound)&&(identical(other.ageRestricted, ageRestricted) || other.ageRestricted == ageRestricted)&&(identical(other.videoCaption, videoCaption) || other.videoCaption == videoCaption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,postedBy,uploaderProfilePicture,uploaderName,likesCount,SavedCount,shareCount,commentsCount,viewsCount,isLiked,isSaved,DownloadAllow,videoUrl,thumbnailUrl,videoGenre,ShareLink,locationTag,duration,originalAudioOwnerId,videoResolution,videoRatio,PrivacyType,isOriginalSound,ageRestricted,videoCaption]);

@override
String toString() {
  return 'VideoModel(id: $id, postedBy: $postedBy, uploaderProfilePicture: $uploaderProfilePicture, uploaderName: $uploaderName, likesCount: $likesCount, SavedCount: $SavedCount, shareCount: $shareCount, commentsCount: $commentsCount, viewsCount: $viewsCount, isLiked: $isLiked, isSaved: $isSaved, DownloadAllow: $DownloadAllow, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl, videoGenre: $videoGenre, ShareLink: $ShareLink, locationTag: $locationTag, duration: $duration, originalAudioOwnerId: $originalAudioOwnerId, videoResolution: $videoResolution, videoRatio: $videoRatio, PrivacyType: $PrivacyType, isOriginalSound: $isOriginalSound, ageRestricted: $ageRestricted, videoCaption: $videoCaption)';
}


}

/// @nodoc
abstract mixin class $VideoModelCopyWith<$Res>  {
  factory $VideoModelCopyWith(VideoModel value, $Res Function(VideoModel) _then) = _$VideoModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) int? id,@JsonKey(includeIfNull: false) int? postedBy,@JsonKey(includeIfNull: false) String? uploaderProfilePicture,@JsonKey(includeIfNull: false) String? uploaderName,@JsonKey(includeIfNull: false) int? likesCount,@JsonKey(includeIfNull: false) int? SavedCount,@JsonKey(includeIfNull: false) int? shareCount,@JsonKey(includeIfNull: false) int? commentsCount,@JsonKey(includeIfNull: false) int? viewsCount,@JsonKey(includeIfNull: false) bool? isLiked,@JsonKey(includeIfNull: false) bool? isSaved,@JsonKey(includeIfNull: false)@BoolFromIntConverter() bool? DownloadAllow, String videoUrl, String thumbnailUrl, String videoGenre, String ShareLink, String locationTag, int duration, int originalAudioOwnerId, String videoResolution, String videoRatio, String PrivacyType,@BoolFromIntConverter() bool isOriginalSound,@BoolFromIntConverter() bool ageRestricted,@JsonKey(includeIfNull: false) String? videoCaption
});




}
/// @nodoc
class _$VideoModelCopyWithImpl<$Res>
    implements $VideoModelCopyWith<$Res> {
  _$VideoModelCopyWithImpl(this._self, this._then);

  final VideoModel _self;
  final $Res Function(VideoModel) _then;

/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? postedBy = freezed,Object? uploaderProfilePicture = freezed,Object? uploaderName = freezed,Object? likesCount = freezed,Object? SavedCount = freezed,Object? shareCount = freezed,Object? commentsCount = freezed,Object? viewsCount = freezed,Object? isLiked = freezed,Object? isSaved = freezed,Object? DownloadAllow = freezed,Object? videoUrl = null,Object? thumbnailUrl = null,Object? videoGenre = null,Object? ShareLink = null,Object? locationTag = null,Object? duration = null,Object? originalAudioOwnerId = null,Object? videoResolution = null,Object? videoRatio = null,Object? PrivacyType = null,Object? isOriginalSound = null,Object? ageRestricted = null,Object? videoCaption = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,postedBy: freezed == postedBy ? _self.postedBy : postedBy // ignore: cast_nullable_to_non_nullable
as int?,uploaderProfilePicture: freezed == uploaderProfilePicture ? _self.uploaderProfilePicture : uploaderProfilePicture // ignore: cast_nullable_to_non_nullable
as String?,uploaderName: freezed == uploaderName ? _self.uploaderName : uploaderName // ignore: cast_nullable_to_non_nullable
as String?,likesCount: freezed == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int?,SavedCount: freezed == SavedCount ? _self.SavedCount : SavedCount // ignore: cast_nullable_to_non_nullable
as int?,shareCount: freezed == shareCount ? _self.shareCount : shareCount // ignore: cast_nullable_to_non_nullable
as int?,commentsCount: freezed == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int?,viewsCount: freezed == viewsCount ? _self.viewsCount : viewsCount // ignore: cast_nullable_to_non_nullable
as int?,isLiked: freezed == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool?,isSaved: freezed == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool?,DownloadAllow: freezed == DownloadAllow ? _self.DownloadAllow : DownloadAllow // ignore: cast_nullable_to_non_nullable
as bool?,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,videoGenre: null == videoGenre ? _self.videoGenre : videoGenre // ignore: cast_nullable_to_non_nullable
as String,ShareLink: null == ShareLink ? _self.ShareLink : ShareLink // ignore: cast_nullable_to_non_nullable
as String,locationTag: null == locationTag ? _self.locationTag : locationTag // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,originalAudioOwnerId: null == originalAudioOwnerId ? _self.originalAudioOwnerId : originalAudioOwnerId // ignore: cast_nullable_to_non_nullable
as int,videoResolution: null == videoResolution ? _self.videoResolution : videoResolution // ignore: cast_nullable_to_non_nullable
as String,videoRatio: null == videoRatio ? _self.videoRatio : videoRatio // ignore: cast_nullable_to_non_nullable
as String,PrivacyType: null == PrivacyType ? _self.PrivacyType : PrivacyType // ignore: cast_nullable_to_non_nullable
as String,isOriginalSound: null == isOriginalSound ? _self.isOriginalSound : isOriginalSound // ignore: cast_nullable_to_non_nullable
as bool,ageRestricted: null == ageRestricted ? _self.ageRestricted : ageRestricted // ignore: cast_nullable_to_non_nullable
as bool,videoCaption: freezed == videoCaption ? _self.videoCaption : videoCaption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _VideoModel implements VideoModel {
  const _VideoModel({@JsonKey(includeIfNull: false) this.id, @JsonKey(includeIfNull: false) this.postedBy, @JsonKey(includeIfNull: false) this.uploaderProfilePicture, @JsonKey(includeIfNull: false) this.uploaderName, @JsonKey(includeIfNull: false) this.likesCount, @JsonKey(includeIfNull: false) this.SavedCount, @JsonKey(includeIfNull: false) this.shareCount, @JsonKey(includeIfNull: false) this.commentsCount, @JsonKey(includeIfNull: false) this.viewsCount, @JsonKey(includeIfNull: false) this.isLiked, @JsonKey(includeIfNull: false) this.isSaved, @JsonKey(includeIfNull: false)@BoolFromIntConverter() this.DownloadAllow, required this.videoUrl, required this.thumbnailUrl, required this.videoGenre, required this.ShareLink, required this.locationTag, required this.duration, required this.originalAudioOwnerId, required this.videoResolution, required this.videoRatio, required this.PrivacyType, @BoolFromIntConverter() required this.isOriginalSound, @BoolFromIntConverter() required this.ageRestricted, @JsonKey(includeIfNull: false) this.videoCaption});
  factory _VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);

@override@JsonKey(includeIfNull: false) final  int? id;
@override@JsonKey(includeIfNull: false) final  int? postedBy;
@override@JsonKey(includeIfNull: false) final  String? uploaderProfilePicture;
@override@JsonKey(includeIfNull: false) final  String? uploaderName;
@override@JsonKey(includeIfNull: false) final  int? likesCount;
@override@JsonKey(includeIfNull: false) final  int? SavedCount;
@override@JsonKey(includeIfNull: false) final  int? shareCount;
@override@JsonKey(includeIfNull: false) final  int? commentsCount;
@override@JsonKey(includeIfNull: false) final  int? viewsCount;
@override@JsonKey(includeIfNull: false) final  bool? isLiked;
@override@JsonKey(includeIfNull: false) final  bool? isSaved;
@override@JsonKey(includeIfNull: false)@BoolFromIntConverter() final  bool? DownloadAllow;
@override final  String videoUrl;
@override final  String thumbnailUrl;
@override final  String videoGenre;
@override final  String ShareLink;
@override final  String locationTag;
@override final  int duration;
@override final  int originalAudioOwnerId;
@override final  String videoResolution;
@override final  String videoRatio;
@override final  String PrivacyType;
@override@BoolFromIntConverter() final  bool isOriginalSound;
@override@BoolFromIntConverter() final  bool ageRestricted;
@override@JsonKey(includeIfNull: false) final  String? videoCaption;

/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoModelCopyWith<_VideoModel> get copyWith => __$VideoModelCopyWithImpl<_VideoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.postedBy, postedBy) || other.postedBy == postedBy)&&(identical(other.uploaderProfilePicture, uploaderProfilePicture) || other.uploaderProfilePicture == uploaderProfilePicture)&&(identical(other.uploaderName, uploaderName) || other.uploaderName == uploaderName)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.SavedCount, SavedCount) || other.SavedCount == SavedCount)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.viewsCount, viewsCount) || other.viewsCount == viewsCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved)&&(identical(other.DownloadAllow, DownloadAllow) || other.DownloadAllow == DownloadAllow)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.videoGenre, videoGenre) || other.videoGenre == videoGenre)&&(identical(other.ShareLink, ShareLink) || other.ShareLink == ShareLink)&&(identical(other.locationTag, locationTag) || other.locationTag == locationTag)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.originalAudioOwnerId, originalAudioOwnerId) || other.originalAudioOwnerId == originalAudioOwnerId)&&(identical(other.videoResolution, videoResolution) || other.videoResolution == videoResolution)&&(identical(other.videoRatio, videoRatio) || other.videoRatio == videoRatio)&&(identical(other.PrivacyType, PrivacyType) || other.PrivacyType == PrivacyType)&&(identical(other.isOriginalSound, isOriginalSound) || other.isOriginalSound == isOriginalSound)&&(identical(other.ageRestricted, ageRestricted) || other.ageRestricted == ageRestricted)&&(identical(other.videoCaption, videoCaption) || other.videoCaption == videoCaption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,postedBy,uploaderProfilePicture,uploaderName,likesCount,SavedCount,shareCount,commentsCount,viewsCount,isLiked,isSaved,DownloadAllow,videoUrl,thumbnailUrl,videoGenre,ShareLink,locationTag,duration,originalAudioOwnerId,videoResolution,videoRatio,PrivacyType,isOriginalSound,ageRestricted,videoCaption]);

@override
String toString() {
  return 'VideoModel(id: $id, postedBy: $postedBy, uploaderProfilePicture: $uploaderProfilePicture, uploaderName: $uploaderName, likesCount: $likesCount, SavedCount: $SavedCount, shareCount: $shareCount, commentsCount: $commentsCount, viewsCount: $viewsCount, isLiked: $isLiked, isSaved: $isSaved, DownloadAllow: $DownloadAllow, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl, videoGenre: $videoGenre, ShareLink: $ShareLink, locationTag: $locationTag, duration: $duration, originalAudioOwnerId: $originalAudioOwnerId, videoResolution: $videoResolution, videoRatio: $videoRatio, PrivacyType: $PrivacyType, isOriginalSound: $isOriginalSound, ageRestricted: $ageRestricted, videoCaption: $videoCaption)';
}


}

/// @nodoc
abstract mixin class _$VideoModelCopyWith<$Res> implements $VideoModelCopyWith<$Res> {
  factory _$VideoModelCopyWith(_VideoModel value, $Res Function(_VideoModel) _then) = __$VideoModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) int? id,@JsonKey(includeIfNull: false) int? postedBy,@JsonKey(includeIfNull: false) String? uploaderProfilePicture,@JsonKey(includeIfNull: false) String? uploaderName,@JsonKey(includeIfNull: false) int? likesCount,@JsonKey(includeIfNull: false) int? SavedCount,@JsonKey(includeIfNull: false) int? shareCount,@JsonKey(includeIfNull: false) int? commentsCount,@JsonKey(includeIfNull: false) int? viewsCount,@JsonKey(includeIfNull: false) bool? isLiked,@JsonKey(includeIfNull: false) bool? isSaved,@JsonKey(includeIfNull: false)@BoolFromIntConverter() bool? DownloadAllow, String videoUrl, String thumbnailUrl, String videoGenre, String ShareLink, String locationTag, int duration, int originalAudioOwnerId, String videoResolution, String videoRatio, String PrivacyType,@BoolFromIntConverter() bool isOriginalSound,@BoolFromIntConverter() bool ageRestricted,@JsonKey(includeIfNull: false) String? videoCaption
});




}
/// @nodoc
class __$VideoModelCopyWithImpl<$Res>
    implements _$VideoModelCopyWith<$Res> {
  __$VideoModelCopyWithImpl(this._self, this._then);

  final _VideoModel _self;
  final $Res Function(_VideoModel) _then;

/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? postedBy = freezed,Object? uploaderProfilePicture = freezed,Object? uploaderName = freezed,Object? likesCount = freezed,Object? SavedCount = freezed,Object? shareCount = freezed,Object? commentsCount = freezed,Object? viewsCount = freezed,Object? isLiked = freezed,Object? isSaved = freezed,Object? DownloadAllow = freezed,Object? videoUrl = null,Object? thumbnailUrl = null,Object? videoGenre = null,Object? ShareLink = null,Object? locationTag = null,Object? duration = null,Object? originalAudioOwnerId = null,Object? videoResolution = null,Object? videoRatio = null,Object? PrivacyType = null,Object? isOriginalSound = null,Object? ageRestricted = null,Object? videoCaption = freezed,}) {
  return _then(_VideoModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,postedBy: freezed == postedBy ? _self.postedBy : postedBy // ignore: cast_nullable_to_non_nullable
as int?,uploaderProfilePicture: freezed == uploaderProfilePicture ? _self.uploaderProfilePicture : uploaderProfilePicture // ignore: cast_nullable_to_non_nullable
as String?,uploaderName: freezed == uploaderName ? _self.uploaderName : uploaderName // ignore: cast_nullable_to_non_nullable
as String?,likesCount: freezed == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int?,SavedCount: freezed == SavedCount ? _self.SavedCount : SavedCount // ignore: cast_nullable_to_non_nullable
as int?,shareCount: freezed == shareCount ? _self.shareCount : shareCount // ignore: cast_nullable_to_non_nullable
as int?,commentsCount: freezed == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int?,viewsCount: freezed == viewsCount ? _self.viewsCount : viewsCount // ignore: cast_nullable_to_non_nullable
as int?,isLiked: freezed == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool?,isSaved: freezed == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool?,DownloadAllow: freezed == DownloadAllow ? _self.DownloadAllow : DownloadAllow // ignore: cast_nullable_to_non_nullable
as bool?,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,videoGenre: null == videoGenre ? _self.videoGenre : videoGenre // ignore: cast_nullable_to_non_nullable
as String,ShareLink: null == ShareLink ? _self.ShareLink : ShareLink // ignore: cast_nullable_to_non_nullable
as String,locationTag: null == locationTag ? _self.locationTag : locationTag // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,originalAudioOwnerId: null == originalAudioOwnerId ? _self.originalAudioOwnerId : originalAudioOwnerId // ignore: cast_nullable_to_non_nullable
as int,videoResolution: null == videoResolution ? _self.videoResolution : videoResolution // ignore: cast_nullable_to_non_nullable
as String,videoRatio: null == videoRatio ? _self.videoRatio : videoRatio // ignore: cast_nullable_to_non_nullable
as String,PrivacyType: null == PrivacyType ? _self.PrivacyType : PrivacyType // ignore: cast_nullable_to_non_nullable
as String,isOriginalSound: null == isOriginalSound ? _self.isOriginalSound : isOriginalSound // ignore: cast_nullable_to_non_nullable
as bool,ageRestricted: null == ageRestricted ? _self.ageRestricted : ageRestricted // ignore: cast_nullable_to_non_nullable
as bool,videoCaption: freezed == videoCaption ? _self.videoCaption : videoCaption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
