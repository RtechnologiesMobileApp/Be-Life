import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:be_life_style/model/message_model/message_model.dart';

part 'chat_list_model.freezed.dart';
part 'chat_list_model.g.dart';

int _toInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

@freezed
abstract class ChatListModel with _$ChatListModel {
  const factory ChatListModel({
    @JsonKey(name: 'userId') required int chatWith,
    @JsonKey(name: 'username') required String chatWithUsername,
    @JsonKey(name: 'profilePicture') required String profilePicture,
    @JsonKey(name: 'lastMessageTime') required String lastMessageTime,
    @JsonKey(name: 'lastMessage') required String lastMessage,
    @JsonKey(name: 'unreadCount', fromJson: _toInt) required int unreadCount,

    /// Nullable so we can fill it later after fetching chat messages
    List<MessageModel>? messages,
  }) = _ChatListModel;

  factory ChatListModel.fromJson(Map<String, dynamic> json) =>
      _$ChatListModelFromJson(json);
}
