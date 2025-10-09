import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/view_model/main_nav_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  late IO.Socket _socket;
  bool _isInitialized = false;

  IO.Socket get socket => _socket;

  SocketService._internal();

  void initSocket(int userId) {
    if (_isInitialized) return;

    if (userId <= 0) {
      debugPrint("⚠️ Invalid user ID");
      return;
    }

    _socket = IO.io(
      'https://be-life-backend.up.railway.app',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setQuery({'userId': userId.toString()})
          .build(),
    );

    _socket.onConnect((_) {
      print("🔵 CHAT_DEBUG [SOCKET]: Socket Connected: ${_socket.id}");
      debugPrint("✅ Socket Connected: ${_socket.id}");
      print("🔵 CHAT_DEBUG [SOCKET]: Emitting join event with userId: $userId");
      _socket.emit("join", userId);
      
      // Set up global listeners immediately after connection
      _setupGlobalListeners();
    });

    _socket.on("connect_error", (err) {
      debugPrint("❌ Connection error: ${err.message}");
    });
    _socket.onDisconnect((_) => debugPrint("❌ Socket Disconnected"));

    _isInitialized = true;
  }

  void _setupGlobalListeners() {
    print("🔵 CHAT_DEBUG [SOCKET]: Setting up global socket listeners");
    
    // Listen for incoming messages
    _socket.on("receive_message", (data) {
      print("🔵 CHAT_DEBUG [SOCKET]: Global receive_message listener triggered: $data");
      // Increase unread count only if user is not in Inbox tab
      try {
        final mainNav = getIt<MainNavViewModel>();
        if (mainNav.selectedIndex != 1) {
          print("🔵 CHAT_DEBUG [SOCKET]: Incrementing unread count");
          mainNav.incrementUnread();
        } else {
          print("🔵 CHAT_DEBUG [SOCKET]: User is in inbox tab, not incrementing counter");
        }
      } catch (e) {
        print("🔵 CHAT_DEBUG [SOCKET]: Error accessing MainNavViewModel: $e");
        debugPrint("Error accessing MainNavViewModel: $e");
      }
    });

    // Listen for new notifications
    _socket.on("new_notification", (data) {
      print("🔵 CHAT_DEBUG [SOCKET]: Global new_notification listener triggered: $data");
      try {
        final mainNav = getIt<MainNavViewModel>();
        mainNav.incrementUnread();
        print("🔵 CHAT_DEBUG [SOCKET]: Notification unread count incremented");
      } catch (e) {
        print("🔵 CHAT_DEBUG [SOCKET]: Error accessing MainNavViewModel for notification: $e");
        debugPrint("Error accessing MainNavViewModel for notification: $e");
      }
    });
    
    print("🔵 CHAT_DEBUG [SOCKET]: Global listeners setup complete");
  }

  void dispose() {
    _socket.disconnect();
    _socket.destroy();
  }
}
