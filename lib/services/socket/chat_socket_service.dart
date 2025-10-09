import 'package:socket_io_client/socket_io_client.dart';
import 'socket_service.dart';

class ChatSocketService {
  final Socket _socket = SocketService().socket;

  // Send a message to the receiver
  void sendMessage({
    required int receiverId,
    required String content,
  }) {
    print("🔵 CHAT_DEBUG [SOCKET]: Socket emitting send_message with receiverId: $receiverId, content: $content");
    _socket.emit("send_message", {
      "receiverId": receiverId,
      "content": content,
    });
  }

  // Open a chat and listen for chat history
  void openChat({required int otherUserId}) {
    print("🔵 CHAT_DEBUG [SOCKET]: Socket emitting open_chat with otherUserId: $otherUserId");
    _socket.emit("open_chat", {"otherUserId": otherUserId});
  }

  // Listen for chat history when opening a chat
  void onChatHistory(Function(dynamic messages) callback) {
    print("🔵 CHAT_DEBUG [SOCKET]: Socket setting up chat_history listener");
    _socket.on("chat_history", callback);
  }

  // Listen for incoming messages
  void onReceiveMessage(Function(dynamic message) callback) {
    print("🔵 CHAT_DEBUG [SOCKET]: Socket setting up receive_message listener");
    _socket.on("receive_message", (data) {
      print("🔵 CHAT_DEBUG [SOCKET]: Socket received message: $data");
      callback(data);
    });
  }

  // Listen for message sent confirmation
  void onMessageSent(Function(dynamic message) callback) {
    print("🔵 CHAT_DEBUG [SOCKET]: Socket setting up message_sent listener");
    _socket.on("message_sent", callback);
  }


  // Handle typing event
  void sendTyping({required int toUserId}) {
    _socket.emit("typing", {"toUserId": toUserId});
  }

  // Handle stop typing event
  void stopTyping({required int toUserId}) {
    _socket.emit("stop_typing", {"toUserId": toUserId});
  }

  // Listen for typing events
  void onTyping(Function(dynamic data) callback) {
    _socket.on("typing", callback);
  }

  // Listen for stop typing events
  void onStopTyping(Function(dynamic data) callback) {
    _socket.on("stop_typing", callback);
  }

  // Mark messages as read
  void markMessagesAsRead({
    required int otherUserId,
  }) {
    print("🔵 CHAT_DEBUG [SOCKET]: Socket emitting mark_as_read with otherUserId: $otherUserId");
    _socket.emit("mark_as_read", {
      "otherUserId": otherUserId,
    });
  }

  // Dispose chat listeners
  void disposeChatListeners() {
    _socket.off("receive_message");
    _socket.off("message_sent");
    _socket.off("chat_history");
    _socket.off("typing");
    _socket.off("stop_typing");
  }
}
