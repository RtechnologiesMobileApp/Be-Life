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

@JsonKey(name: 'userId') int get chatWith;@JsonKey(name: 'username') String get chatWithUsername;@JsonKey(name: 'profilePicture') String get profilePicture;@JsonKey(name: 'lastMessageTime') String get lastMessageTime;@JsonKey(name: 'lastMessage') String get lastMessage;@JsonKey(name: 'unreadCount', fromJson: _toInt) int get unreadCount;/// Nullable so we can fill it later after fetching chat messages
 List<MessageModel>? get messages;
/// Create a copy of ChatListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatListModelCopyWith<ChatListModel> get copyWith => _$ChatListModelCopyWithImpl<ChatListModel>(this as ChatListModel, _$identity);

  /// Serializes this ChatListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatListModel&&(identical(other.chatWith, chatWith) || other.chatWith == chatWith)&&(identical(other.chatWithUsername, chatWithUsername) || other.chatWithUsername == chatWithUsername)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.lastMessageTime, lastMessageTime) || other.lastMessageTime == lastMessageTime)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&const DeepCollectionEquality().equals(other.messages, messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatWith,chatWithUsername,profilePicture,lastMessageTime,lastMessage,unreadCount,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'ChatListModel(chatWith: $chatWith, chatWithUsername: $chatWithUsername, profilePicture: $profilePicture, lastMessageTime: $lastMessageTime, lastMessage: $lastMessage, unreadCount: $unreadCount, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $ChatListModelCopyWith<$Res>  {
  factory $ChatListModelCopyWith(ChatListModel value, $Res Function(ChatListModel) _then) = _$ChatListModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'userId') int chatWith,@JsonKey(name: 'username') String chatWithUsername,@JsonKey(name: 'profilePicture') String profilePicture,@JsonKey(name: 'lastMessageTime') String lastMessageTime,@JsonKey(name: 'lastMessage') String lastMessage,@JsonKey(name: 'unreadCount', fromJson: _toInt) int unreadCount, List<MessageModel>? messages
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
@pragma('vm:prefer-inline') @override $Res call({Object? chatWith = null,Object? chatWithUsername = null,Object? profilePicture = null,Object? lastMessageTime = null,Object? lastMessage = null,Object? unreadCount = null,Object? messages = freezed,}) {
  return _then(_self.copyWith(
chatWith: null == chatWith ? _self.chatWith : chatWith // ignore: cast_nullable_to_non_nullable
as int,chatWithUsername: null == chatWithUsername ? _self.chatWithUsername : chatWithUsername // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,lastMessageTime: null == lastMessageTime ? _self.lastMessageTime : lastMessageTime // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,messages: freezed == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<MessageModel>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ChatListModel implements ChatListModel {
  const _ChatListModel({@JsonKey(name: 'userId') required this.chatWith, @JsonKey(name: 'username') required this.chatWithUsername, @JsonKey(name: 'profilePicture') required this.profilePicture, @JsonKey(name: 'lastMessageTime') required this.lastMessageTime, @JsonKey(name: 'lastMessage') required this.lastMessage, @JsonKey(name: 'unreadCount', fromJson: _toInt) required this.unreadCount, final  List<MessageModel>? messages}): _messages = messages;
  factory _ChatListModel.fromJson(Map<String, dynamic> json) => _$ChatListModelFromJson(json);

@override@JsonKey(name: 'userId') final  int chatWith;
@override@JsonKey(name: 'username') final  String chatWithUsername;
@override@JsonKey(name: 'profilePicture') final  String profilePicture;
@override@JsonKey(name: 'lastMessageTime') final  String lastMessageTime;
@override@JsonKey(name: 'lastMessage') final  String lastMessage;
@override@JsonKey(name: 'unreadCount', fromJson: _toInt) final  int unreadCount;
/// Nullable so we can fill it later after fetching chat messages
 final  List<MessageModel>? _messages;
/// Nullable so we can fill it later after fetching chat messages
@override List<MessageModel>? get messages {
  final value = _messages;
  if (value == null) return null;
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatListModel&&(identical(other.chatWith, chatWith) || other.chatWith == chatWith)&&(identical(other.chatWithUsername, chatWithUsername) || other.chatWithUsername == chatWithUsername)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.lastMessageTime, lastMessageTime) || other.lastMessageTime == lastMessageTime)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&const DeepCollectionEquality().equals(other._messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatWith,chatWithUsername,profilePicture,lastMessageTime,lastMessage,unreadCount,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'ChatListModel(chatWith: $chatWith, chatWithUsername: $chatWithUsername, profilePicture: $profilePicture, lastMessageTime: $lastMessageTime, lastMessage: $lastMessage, unreadCount: $unreadCount, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$ChatListModelCopyWith<$Res> implements $ChatListModelCopyWith<$Res> {
  factory _$ChatListModelCopyWith(_ChatListModel value, $Res Function(_ChatListModel) _then) = __$ChatListModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'userId') int chatWith,@JsonKey(name: 'username') String chatWithUsername,@JsonKey(name: 'profilePicture') String profilePicture,@JsonKey(name: 'lastMessageTime') String lastMessageTime,@JsonKey(name: 'lastMessage') String lastMessage,@JsonKey(name: 'unreadCount', fromJson: _toInt) int unreadCount, List<MessageModel>? messages
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
@override @pragma('vm:prefer-inline') $Res call({Object? chatWith = null,Object? chatWithUsername = null,Object? profilePicture = null,Object? lastMessageTime = null,Object? lastMessage = null,Object? unreadCount = null,Object? messages = freezed,}) {
  return _then(_ChatListModel(
chatWith: null == chatWith ? _self.chatWith : chatWith // ignore: cast_nullable_to_non_nullable
as int,chatWithUsername: null == chatWithUsername ? _self.chatWithUsername : chatWithUsername // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,lastMessageTime: null == lastMessageTime ? _self.lastMessageTime : lastMessageTime // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,messages: freezed == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<MessageModel>?,
  ));
}


}

// dart format on
