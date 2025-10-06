import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_converters.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    @JsonKey(includeIfNull: false)  int? id,
    required int senderId,
    required int receiverId,
    required String content,
    @JsonKey(includeIfNull: false)  DateTime? createdAt,
    @JsonKey(includeIfNull: false)  @BoolFromIntConverter() bool? isRead,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
