import 'package:socket_io_client/socket_io_client.dart';
import 'socket_service.dart';

class ChatSocketService {
  final Socket _socket = SocketService().socket;

  // Send a message to the receiver
  void sendMessage({
    required int senderId,
    required int receiverId,
    required String content,
  }) {
    _socket.emit("send_message", {
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content,
    });
  }

  void onReceiveMessage(Function(dynamic message) callback) {
    print("🔥 Setting up ChatViewModel message callback");
    _socket.on("receive_message", (data) {
      print("🔥 ChatViewModel message received: $data");
      callback(data);
    });
    print("🔥 ChatViewModel message callback setup complete");
  }


  // Handle typing event
  void sendTyping({required String toUserId}) {
    _socket.emit("typing", {"toUserId": toUserId});
  }

  // Handle stop typing event
  void stopTyping({required String toUserId}) {
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
    required String senderId,
    required String receiverId,
  }) {
    _socket.emit("mark_as_read", {
      "senderId": senderId,
      "receiverId": receiverId,
    });
  }

  // Dispose chat listeners
  void disposeChatListeners() {
    _socket.off("receive_message");
    _socket.off("typing");
    _socket.off("stop_typing");
  }
}
