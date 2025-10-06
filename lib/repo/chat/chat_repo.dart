import 'package:be_life_style/model/chat_list_model/chat_list_model.dart';
import 'package:be_life_style/model/message_model/message_model.dart';

abstract class ChatRepo{
  Future<List<ChatListModel>> fetchChatList({required String token});
  Future<List<MessageModel>> fetchChatMessages({required int id,required String token,required int page});

}