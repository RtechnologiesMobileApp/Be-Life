// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSearchModel {

 int get id; String get username; String get firstName; String get lastName; String get profilePicture; bool get isFollowing; bool get isFollowedBy;
/// Create a copy of UserSearchModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchModelCopyWith<UserSearchModel> get copyWith => _$UserSearchModelCopyWithImpl<UserSearchModel>(this as UserSearchModel, _$identity);

  /// Serializes this UserSearchModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.isFollowedBy, isFollowedBy) || other.isFollowedBy == isFollowedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,firstName,lastName,profilePicture,isFollowing,isFollowedBy);

@override
String toString() {
  return 'UserSearchModel(id: $id, username: $username, firstName: $firstName, lastName: $lastName, profilePicture: $profilePicture, isFollowing: $isFollowing, isFollowedBy: $isFollowedBy)';
}


}

/// @nodoc
abstract mixin class $UserSearchModelCopyWith<$Res>  {
  factory $UserSearchModelCopyWith(UserSearchModel value, $Res Function(UserSearchModel) _then) = _$UserSearchModelCopyWithImpl;
@useResult
$Res call({
 int id, String username, String firstName, String lastName, String profilePicture, bool isFollowing, bool isFollowedBy
});




}
/// @nodoc
class _$UserSearchModelCopyWithImpl<$Res>
    implements $UserSearchModelCopyWith<$Res> {
  _$UserSearchModelCopyWithImpl(this._self, this._then);

  final UserSearchModel _self;
  final $Res Function(UserSearchModel) _then;

/// Create a copy of UserSearchModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? firstName = null,Object? lastName = null,Object? profilePicture = null,Object? isFollowing = null,Object? isFollowedBy = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,isFollowedBy: null == isFollowedBy ? _self.isFollowedBy : isFollowedBy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UserSearchModel implements UserSearchModel {
  const _UserSearchModel({this.id = -1, required this.username, required this.firstName, required this.lastName, required this.profilePicture, this.isFollowing = false, this.isFollowedBy = false});
  factory _UserSearchModel.fromJson(Map<String, dynamic> json) => _$UserSearchModelFromJson(json);

@override@JsonKey() final  int id;
@override final  String username;
@override final  String firstName;
@override final  String lastName;
@override final  String profilePicture;
@override@JsonKey() final  bool isFollowing;
@override@JsonKey() final  bool isFollowedBy;

/// Create a copy of UserSearchModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchModelCopyWith<_UserSearchModel> get copyWith => __$UserSearchModelCopyWithImpl<_UserSearchModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSearchModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.isFollowedBy, isFollowedBy) || other.isFollowedBy == isFollowedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,firstName,lastName,profilePicture,isFollowing,isFollowedBy);

@override
String toString() {
  return 'UserSearchModel(id: $id, username: $username, firstName: $firstName, lastName: $lastName, profilePicture: $profilePicture, isFollowing: $isFollowing, isFollowedBy: $isFollowedBy)';
}


}

/// @nodoc
abstract mixin class _$UserSearchModelCopyWith<$Res> implements $UserSearchModelCopyWith<$Res> {
  factory _$UserSearchModelCopyWith(_UserSearchModel value, $Res Function(_UserSearchModel) _then) = __$UserSearchModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String firstName, String lastName, String profilePicture, bool isFollowing, bool isFollowedBy
});




}
/// @nodoc
class __$UserSearchModelCopyWithImpl<$Res>
    implements _$UserSearchModelCopyWith<$Res> {
  __$UserSearchModelCopyWithImpl(this._self, this._then);

  final _UserSearchModel _self;
  final $Res Function(_UserSearchModel) _then;

/// Create a copy of UserSearchModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? firstName = null,Object? lastName = null,Object? profilePicture = null,Object? isFollowing = null,Object? isFollowedBy = null,}) {
  return _then(_UserSearchModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,isFollowedBy: null == isFollowedBy ? _self.isFollowedBy : isFollowedBy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
