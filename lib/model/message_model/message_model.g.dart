// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: (json['id'] as num?)?.toInt(),
      senderId: (json['senderId'] as num).toInt(),
      receiverId: (json['receiverId'] as num).toInt(),
      content: json['content'] as String,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      isRead: const BoolFromIntConverter().fromJson(json['isRead']),
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'content': instance.content,
      if (instance.createdAt?.toIso8601String() case final value?)
        'createdAt': value,
      if (_$JsonConverterToJson<dynamic, bool>(
            instance.isRead,
            const BoolFromIntConverter().toJson,
          )
          case final value?)
        'isRead': value,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
