import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_list_model.freezed.dart';
part 'chat_list_model.g.dart';

@freezed
abstract class ChatListModel with _$ChatListModel {
  const factory ChatListModel({
    required int chatWith,
    required String chatWithUsername,
    required String profilePicture,
    required String lastMessageTime,
    required String lastMessage,
    required int unreadCount,
  }) = _ChatListModel;

  factory ChatListModel.fromJson(Map<String, dynamic> json) =>
      _$ChatListModelFromJson(json);
}
