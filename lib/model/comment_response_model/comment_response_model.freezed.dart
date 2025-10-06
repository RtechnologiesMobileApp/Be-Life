// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentResponseModel {

 int get id; int get userId; int get videoId; int? get parentId; bool? get isLiked; String get text; int get likesCount; String get createdAt; String get username; String get profilePicture; List<Reply> get replies;
/// Create a copy of CommentResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentResponseModelCopyWith<CommentResponseModel> get copyWith => _$CommentResponseModelCopyWithImpl<CommentResponseModel>(this as CommentResponseModel, _$identity);

  /// Serializes this CommentResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.text, text) || other.text == text)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.username, username) || other.username == username)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&const DeepCollectionEquality().equals(other.replies, replies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,videoId,parentId,isLiked,text,likesCount,createdAt,username,profilePicture,const DeepCollectionEquality().hash(replies));

@override
String toString() {
  return 'CommentResponseModel(id: $id, userId: $userId, videoId: $videoId, parentId: $parentId, isLiked: $isLiked, text: $text, likesCount: $likesCount, createdAt: $createdAt, username: $username, profilePicture: $profilePicture, replies: $replies)';
}


}

/// @nodoc
abstract mixin class $CommentResponseModelCopyWith<$Res>  {
  factory $CommentResponseModelCopyWith(CommentResponseModel value, $Res Function(CommentResponseModel) _then) = _$CommentResponseModelCopyWithImpl;
@useResult
$Res call({
 int id, int userId, int videoId, int? parentId, bool? isLiked, String text, int likesCount, String createdAt, String username, String profilePicture, List<Reply> replies
});




}
/// @nodoc
class _$CommentResponseModelCopyWithImpl<$Res>
    implements $CommentResponseModelCopyWith<$Res> {
  _$CommentResponseModelCopyWithImpl(this._self, this._then);

  final CommentResponseModel _self;
  final $Res Function(CommentResponseModel) _then;

/// Create a copy of CommentResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? videoId = null,Object? parentId = freezed,Object? isLiked = freezed,Object? text = null,Object? likesCount = null,Object? createdAt = null,Object? username = null,Object? profilePicture = null,Object? replies = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as int,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,isLiked: freezed == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<Reply>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CommentResponseModel implements CommentResponseModel {
   _CommentResponseModel({required this.id, required this.userId, required this.videoId, this.parentId, this.isLiked, required this.text, required this.likesCount, required this.createdAt, required this.username, required this.profilePicture, final  List<Reply> replies = const []}): _replies = replies;
  factory _CommentResponseModel.fromJson(Map<String, dynamic> json) => _$CommentResponseModelFromJson(json);

@override final  int id;
@override final  int userId;
@override final  int videoId;
@override final  int? parentId;
@override final  bool? isLiked;
@override final  String text;
@override final  int likesCount;
@override final  String createdAt;
@override final  String username;
@override final  String profilePicture;
 final  List<Reply> _replies;
@override@JsonKey() List<Reply> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}


/// Create a copy of CommentResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentResponseModelCopyWith<_CommentResponseModel> get copyWith => __$CommentResponseModelCopyWithImpl<_CommentResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.text, text) || other.text == text)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.username, username) || other.username == username)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&const DeepCollectionEquality().equals(other._replies, _replies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,videoId,parentId,isLiked,text,likesCount,createdAt,username,profilePicture,const DeepCollectionEquality().hash(_replies));

@override
String toString() {
  return 'CommentResponseModel(id: $id, userId: $userId, videoId: $videoId, parentId: $parentId, isLiked: $isLiked, text: $text, likesCount: $likesCount, createdAt: $createdAt, username: $username, profilePicture: $profilePicture, replies: $replies)';
}


}

/// @nodoc
abstract mixin class _$CommentResponseModelCopyWith<$Res> implements $CommentResponseModelCopyWith<$Res> {
  factory _$CommentResponseModelCopyWith(_CommentResponseModel value, $Res Function(_CommentResponseModel) _then) = __$CommentResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int userId, int videoId, int? parentId, bool? isLiked, String text, int likesCount, String createdAt, String username, String profilePicture, List<Reply> replies
});




}
/// @nodoc
class __$CommentResponseModelCopyWithImpl<$Res>
    implements _$CommentResponseModelCopyWith<$Res> {
  __$CommentResponseModelCopyWithImpl(this._self, this._then);

  final _CommentResponseModel _self;
  final $Res Function(_CommentResponseModel) _then;

/// Create a copy of CommentResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? videoId = null,Object? parentId = freezed,Object? isLiked = freezed,Object? text = null,Object? likesCount = null,Object? createdAt = null,Object? username = null,Object? profilePicture = null,Object? replies = null,}) {
  return _then(_CommentResponseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as int,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,isLiked: freezed == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<Reply>,
  ));
}


}


/// @nodoc
mixin _$Reply {

 int get id; int get userId; int get videoId; int? get parentId; String get text; int get likesCount; String get createdAt; String get username; String get profilePicture;
/// Create a copy of Reply
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyCopyWith<Reply> get copyWith => _$ReplyCopyWithImpl<Reply>(this as Reply, _$identity);

  /// Serializes this Reply to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reply&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.text, text) || other.text == text)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.username, username) || other.username == username)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,videoId,parentId,text,likesCount,createdAt,username,profilePicture);

@override
String toString() {
  return 'Reply(id: $id, userId: $userId, videoId: $videoId, parentId: $parentId, text: $text, likesCount: $likesCount, createdAt: $createdAt, username: $username, profilePicture: $profilePicture)';
}


}

/// @nodoc
abstract mixin class $ReplyCopyWith<$Res>  {
  factory $ReplyCopyWith(Reply value, $Res Function(Reply) _then) = _$ReplyCopyWithImpl;
@useResult
$Res call({
 int id, int userId, int videoId, int? parentId, String text, int likesCount, String createdAt, String username, String profilePicture
});




}
/// @nodoc
class _$ReplyCopyWithImpl<$Res>
    implements $ReplyCopyWith<$Res> {
  _$ReplyCopyWithImpl(this._self, this._then);

  final Reply _self;
  final $Res Function(Reply) _then;

/// Create a copy of Reply
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? videoId = null,Object? parentId = freezed,Object? text = null,Object? likesCount = null,Object? createdAt = null,Object? username = null,Object? profilePicture = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as int,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Reply implements Reply {
   _Reply({required this.id, required this.userId, required this.videoId, this.parentId, required this.text, required this.likesCount, required this.createdAt, required this.username, required this.profilePicture});
  factory _Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);

@override final  int id;
@override final  int userId;
@override final  int videoId;
@override final  int? parentId;
@override final  String text;
@override final  int likesCount;
@override final  String createdAt;
@override final  String username;
@override final  String profilePicture;

/// Create a copy of Reply
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyCopyWith<_Reply> get copyWith => __$ReplyCopyWithImpl<_Reply>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reply&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.text, text) || other.text == text)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.username, username) || other.username == username)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,videoId,parentId,text,likesCount,createdAt,username,profilePicture);

@override
String toString() {
  return 'Reply(id: $id, userId: $userId, videoId: $videoId, parentId: $parentId, text: $text, likesCount: $likesCount, createdAt: $createdAt, username: $username, profilePicture: $profilePicture)';
}


}

/// @nodoc
abstract mixin class _$ReplyCopyWith<$Res> implements $ReplyCopyWith<$Res> {
  factory _$ReplyCopyWith(_Reply value, $Res Function(_Reply) _then) = __$ReplyCopyWithImpl;
@override @useResult
$Res call({
 int id, int userId, int videoId, int? parentId, String text, int likesCount, String createdAt, String username, String profilePicture
});




}
/// @nodoc
class __$ReplyCopyWithImpl<$Res>
    implements _$ReplyCopyWith<$Res> {
  __$ReplyCopyWithImpl(this._self, this._then);

  final _Reply _self;
  final $Res Function(_Reply) _then;

/// Create a copy of Reply
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? videoId = null,Object? parentId = freezed,Object? text = null,Object? likesCount = null,Object? createdAt = null,Object? username = null,Object? profilePicture = null,}) {
  return _then(_Reply(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as int,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
