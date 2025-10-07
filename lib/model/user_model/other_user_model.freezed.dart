// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtherUserModel {

 int get id; String get username; String get firstName; String get lastName; String? get email; String get profilePicture; List<String> get interests; int? get followersCount; int? get followingCount; int? get likesCount; bool get isFollowing; bool get isFollowedBy;
/// Create a copy of OtherUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtherUserModelCopyWith<OtherUserModel> get copyWith => _$OtherUserModelCopyWithImpl<OtherUserModel>(this as OtherUserModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtherUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&const DeepCollectionEquality().equals(other.interests, interests)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.isFollowedBy, isFollowedBy) || other.isFollowedBy == isFollowedBy));
}


@override
int get hashCode => Object.hash(runtimeType,id,username,firstName,lastName,email,profilePicture,const DeepCollectionEquality().hash(interests),followersCount,followingCount,likesCount,isFollowing,isFollowedBy);

@override
String toString() {
  return 'OtherUserModel(id: $id, username: $username, firstName: $firstName, lastName: $lastName, email: $email, profilePicture: $profilePicture, interests: $interests, followersCount: $followersCount, followingCount: $followingCount, likesCount: $likesCount, isFollowing: $isFollowing, isFollowedBy: $isFollowedBy)';
}


}

/// @nodoc
abstract mixin class $OtherUserModelCopyWith<$Res>  {
  factory $OtherUserModelCopyWith(OtherUserModel value, $Res Function(OtherUserModel) _then) = _$OtherUserModelCopyWithImpl;
@useResult
$Res call({
 int id, String username, String firstName, String lastName, String? email, String profilePicture, List<String> interests, int? followersCount, int? followingCount, int? likesCount, bool isFollowing, bool isFollowedBy
});




}
/// @nodoc
class _$OtherUserModelCopyWithImpl<$Res>
    implements $OtherUserModelCopyWith<$Res> {
  _$OtherUserModelCopyWithImpl(this._self, this._then);

  final OtherUserModel _self;
  final $Res Function(OtherUserModel) _then;

/// Create a copy of OtherUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? firstName = null,Object? lastName = null,Object? email = freezed,Object? profilePicture = null,Object? interests = null,Object? followersCount = freezed,Object? followingCount = freezed,Object? likesCount = freezed,Object? isFollowing = null,Object? isFollowedBy = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,followersCount: freezed == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int?,followingCount: freezed == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int?,likesCount: freezed == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int?,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,isFollowedBy: null == isFollowedBy ? _self.isFollowedBy : isFollowedBy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _OtherUserModel implements OtherUserModel {
  const _OtherUserModel({this.id = -1, required this.username, required this.firstName, required this.lastName, this.email, required this.profilePicture, final  List<String> interests = const [], this.followersCount, this.followingCount, this.likesCount, this.isFollowing = false, this.isFollowedBy = false}): _interests = interests;
  

@override@JsonKey() final  int id;
@override final  String username;
@override final  String firstName;
@override final  String lastName;
@override final  String? email;
@override final  String profilePicture;
 final  List<String> _interests;
@override@JsonKey() List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

@override final  int? followersCount;
@override final  int? followingCount;
@override final  int? likesCount;
@override@JsonKey() final  bool isFollowing;
@override@JsonKey() final  bool isFollowedBy;

/// Create a copy of OtherUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtherUserModelCopyWith<_OtherUserModel> get copyWith => __$OtherUserModelCopyWithImpl<_OtherUserModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtherUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&const DeepCollectionEquality().equals(other._interests, _interests)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.isFollowedBy, isFollowedBy) || other.isFollowedBy == isFollowedBy));
}


@override
int get hashCode => Object.hash(runtimeType,id,username,firstName,lastName,email,profilePicture,const DeepCollectionEquality().hash(_interests),followersCount,followingCount,likesCount,isFollowing,isFollowedBy);

@override
String toString() {
  return 'OtherUserModel(id: $id, username: $username, firstName: $firstName, lastName: $lastName, email: $email, profilePicture: $profilePicture, interests: $interests, followersCount: $followersCount, followingCount: $followingCount, likesCount: $likesCount, isFollowing: $isFollowing, isFollowedBy: $isFollowedBy)';
}


}

/// @nodoc
abstract mixin class _$OtherUserModelCopyWith<$Res> implements $OtherUserModelCopyWith<$Res> {
  factory _$OtherUserModelCopyWith(_OtherUserModel value, $Res Function(_OtherUserModel) _then) = __$OtherUserModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String firstName, String lastName, String? email, String profilePicture, List<String> interests, int? followersCount, int? followingCount, int? likesCount, bool isFollowing, bool isFollowedBy
});




}
/// @nodoc
class __$OtherUserModelCopyWithImpl<$Res>
    implements _$OtherUserModelCopyWith<$Res> {
  __$OtherUserModelCopyWithImpl(this._self, this._then);

  final _OtherUserModel _self;
  final $Res Function(_OtherUserModel) _then;

/// Create a copy of OtherUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? firstName = null,Object? lastName = null,Object? email = freezed,Object? profilePicture = null,Object? interests = null,Object? followersCount = freezed,Object? followingCount = freezed,Object? likesCount = freezed,Object? isFollowing = null,Object? isFollowedBy = null,}) {
  return _then(_OtherUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,followersCount: freezed == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int?,followingCount: freezed == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int?,likesCount: freezed == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int?,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,isFollowedBy: null == isFollowedBy ? _self.isFollowedBy : isFollowedBy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
