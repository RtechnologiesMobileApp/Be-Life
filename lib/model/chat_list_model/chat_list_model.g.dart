// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatListModel _$ChatListModelFromJson(Map<String, dynamic> json) =>
    _ChatListModel(
      chatWith: (json['chatWith'] as num).toInt(),
      chatWithUsername: json['chatWithUsername'] as String,
      profilePicture: json['profilePicture'] as String,
      lastMessageTime: json['lastMessageTime'] as String,
      lastMessage: json['lastMessage'] as String,
      unreadCount: (json['unreadCount'] as num).toInt(),
    );

Map<String, dynamic> _$ChatListModelToJson(_ChatListModel instance) =>
    <String, dynamic>{
      'chatWith': instance.chatWith,
      'chatWithUsername': instance.chatWithUsername,
      'profilePicture': instance.profilePicture,
      'lastMessageTime': instance.lastMessageTime,
      'lastMessage': instance.lastMessage,
      'unreadCount': instance.unreadCount,
    };
