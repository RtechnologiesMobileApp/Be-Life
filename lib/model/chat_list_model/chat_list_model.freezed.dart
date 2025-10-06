// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatListModel {

 int get chatWith; String get chatWithUsername; String get profilePicture; String get lastMessageTime; String get lastMessage; int get unreadCount;
/// Create a copy of ChatListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatListModelCopyWith<ChatListModel> get copyWith => _$ChatListModelCopyWithImpl<ChatListModel>(this as ChatListModel, _$identity);

  /// Serializes this ChatListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatListModel&&(identical(other.chatWith, chatWith) || other.chatWith == chatWith)&&(identical(other.chatWithUsername, chatWithUsername) || other.chatWithUsername == chatWithUsername)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.lastMessageTime, lastMessageTime) || other.lastMessageTime == lastMessageTime)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatWith,chatWithUsername,profilePicture,lastMessageTime,lastMessage,unreadCount);

@override
String toString() {
  return 'ChatListModel(chatWith: $chatWith, chatWithUsername: $chatWithUsername, profilePicture: $profilePicture, lastMessageTime: $lastMessageTime, lastMessage: $lastMessage, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $ChatListModelCopyWith<$Res>  {
  factory $ChatListModelCopyWith(ChatListModel value, $Res Function(ChatListModel) _then) = _$ChatListModelCopyWithImpl;
@useResult
$Res call({
 int chatWith, String chatWithUsername, String profilePicture, String lastMessageTime, String lastMessage, int unreadCount
});




}
/// @nodoc
class _$ChatListModelCopyWithImpl<$Res>
    implements $ChatListModelCopyWith<$Res> {
  _$ChatListModelCopyWithImpl(this._self, this._then);

  final ChatListModel _self;
  final $Res Function(ChatListModel) _then;

/// Create a copy of ChatListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chatWith = null,Object? chatWithUsername = null,Object? profilePicture = null,Object? lastMessageTime = null,Object? lastMessage = null,Object? unreadCount = null,}) {
  return _then(_self.copyWith(
chatWith: null == chatWith ? _self.chatWith : chatWith // ignore: cast_nullable_to_non_nullable
as int,chatWithUsername: null == chatWithUsername ? _self.chatWithUsername : chatWithUsername // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,lastMessageTime: null == lastMessageTime ? _self.lastMessageTime : lastMessageTime // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ChatListModel implements ChatListModel {
  const _ChatListModel({required this.chatWith, required this.chatWithUsername, required this.profilePicture, required this.lastMessageTime, required this.lastMessage, required this.unreadCount});
  factory _ChatListModel.fromJson(Map<String, dynamic> json) => _$ChatListModelFromJson(json);

@override final  int chatWith;
@override final  String chatWithUsername;
@override final  String profilePicture;
@override final  String lastMessageTime;
@override final  String lastMessage;
@override final  int unreadCount;

/// Create a copy of ChatListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatListModelCopyWith<_ChatListModel> get copyWith => __$ChatListModelCopyWithImpl<_ChatListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatListModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatListModel&&(identical(other.chatWith, chatWith) || other.chatWith == chatWith)&&(identical(other.chatWithUsername, chatWithUsername) || other.chatWithUsername == chatWithUsername)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.lastMessageTime, lastMessageTime) || other.lastMessageTime == lastMessageTime)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatWith,chatWithUsername,profilePicture,lastMessageTime,lastMessage,unreadCount);

@override
String toString() {
  return 'ChatListModel(chatWith: $chatWith, chatWithUsername: $chatWithUsername, profilePicture: $profilePicture, lastMessageTime: $lastMessageTime, lastMessage: $lastMessage, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$ChatListModelCopyWith<$Res> implements $ChatListModelCopyWith<$Res> {
  factory _$ChatListModelCopyWith(_ChatListModel value, $Res Function(_ChatListModel) _then) = __$ChatListModelCopyWithImpl;
@override @useResult
$Res call({
 int chatWith, String chatWithUsername, String profilePicture, String lastMessageTime, String lastMessage, int unreadCount
});




}
/// @nodoc
class __$ChatListModelCopyWithImpl<$Res>
    implements _$ChatListModelCopyWith<$Res> {
  __$ChatListModelCopyWithImpl(this._self, this._then);

  final _ChatListModel _self;
  final $Res Function(_ChatListModel) _then;

/// Create a copy of ChatListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chatWith = null,Object? chatWithUsername = null,Object? profilePicture = null,Object? lastMessageTime = null,Object? lastMessage = null,Object? unreadCount = null,}) {
  return _then(_ChatListModel(
chatWith: null == chatWith ? _self.chatWith : chatWith // ignore: cast_nullable_to_non_nullable
as int,chatWithUsername: null == chatWithUsername ? _self.chatWithUsername : chatWithUsername // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,lastMessageTime: null == lastMessageTime ? _self.lastMessageTime : lastMessageTime // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
