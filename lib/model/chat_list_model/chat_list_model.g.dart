// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatListModel _$ChatListModelFromJson(Map<String, dynamic> json) =>
    _ChatListModel(
      chatWith: (json['userId'] as num).toInt(),
      chatWithUsername: json['username'] as String,
      profilePicture: json['profilePicture'] as String,
      lastMessageTime: json['lastMessageTime'] as String,
      lastMessage: json['lastMessage'] as String,
      unreadCount: _toInt(json['unreadCount']),
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ChatListModelToJson(_ChatListModel instance) =>
    <String, dynamic>{
      'userId': instance.chatWith,
      'username': instance.chatWithUsername,
      'profilePicture': instance.profilePicture,
      'lastMessageTime': instance.lastMessageTime,
      'lastMessage': instance.lastMessage,
      'unreadCount': instance.unreadCount,
      'messages': instance.messages,
    };
