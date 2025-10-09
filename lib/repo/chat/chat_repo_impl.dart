import 'package:be_life_style/config/api_endpoints.dart';
import 'package:be_life_style/data/network/base_api_services.dart';
import 'package:be_life_style/model/chat_list_model/chat_list_model.dart';
import 'package:be_life_style/model/message_model/message_model.dart';
import 'package:be_life_style/repo/chat/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  ChatRepoImpl({required this.apiService});
  final BaseApiService apiService;
  @override
  Future<List<ChatListModel>> fetchChatList({required String token}) async {
    try {
      print(
        "🔵 CHAT_DEBUG [API]: Calling fetchChatList with token: ${token.substring(0, 10)}...",
      );
      final response = await apiService.getApi(
        url: ApiEndpoints.fetchChatList,
        token: token,
      );
      print("🔵 CHAT_DEBUG [API]: fetchChatList response: $response");

      List<dynamic> messagesList = [];
      if (response['messages'] != null) {
        messagesList = response['messages'] as List;
      } else if (response['rooms'] != null) {
        messagesList = response['rooms'] as List;
      } else if (response['data'] != null) {
        messagesList = response['data'] as List;
      }

      print(
        "🔵 CHAT_DEBUG [API]: Found ${messagesList.length} items in response",
      );

      // 🧩 Diagnostic: print each record’s field and type before parsing
      for (var i = 0; i < messagesList.length; i++) {
        final item = messagesList[i];
        print("🔎 CHAT_DEBUG [API]: Item #$i field breakdown:");
        item.forEach((key, value) {
          print("   • $key = $value (${value.runtimeType})");
        });
      }

      // Attempt conversion
      final chatList =
          messagesList.map((item) {
            try {
              return ChatListModel.fromJson(item);
            } catch (e) {
              print("🚨 CHAT_DEBUG [API]: Error parsing item: $item");
              print("🚨 Parsing error: $e");
              rethrow;
            }
          }).toList();

      print("🔵 CHAT_DEBUG [API]: Parsed ${chatList.length} chat list items");
      return chatList;
    } catch (e) {
      print("🔵 CHAT_DEBUG: API fetchChatList error: $e");
      rethrow;
    }
  }

  @override
  Future<List<MessageModel>> fetchChatMessages({
    required int id,
    required String token,
    required int page,
  }) async {
    try {
      print(
        "🔵 CHAT_DEBUG [API]: Calling fetchChatMessages for id: $id, page: $page",
      );
      final response = await apiService.getApi(
        url: "${ApiEndpoints.fetchChatMessages}/$id?page=$page",
        token: token,
      );
      print("🔵 CHAT_DEBUG [API]: fetchChatMessages response: $response");

      // Handle different response structures
      List<dynamic> messagesList = [];
      if (response['messages'] != null) {
        messagesList = response['messages'] as List;
      } else if (response['data'] != null) {
        messagesList = response['data'] as List;
      }

      print(
        "🔵 CHAT_DEBUG [API]: Found ${messagesList.length} messages in response",
      );
      List<MessageModel> messagesListParsed =
          messagesList
              .map((messages) => MessageModel.fromJson(messages))
              .toList();
      print(
        "🔵 CHAT_DEBUG [API]: Parsed ${messagesListParsed.length} messages",
      );
      return messagesListParsed;
    } catch (e) {
      print("🔵 CHAT_DEBUG: API fetchChatMessages error: $e");
      rethrow;
    }
  }
}
