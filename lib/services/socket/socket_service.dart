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
      debugPrint("✅ Socket Connected: ${_socket.id}");
      _socket.emit("join", userId);
      
      // Set up message listener immediately after connection
      _setupMessageListener();
    });

    _socket.on("connect_error", (err) {
      debugPrint("❌ Connection error: ${err.message}");
    });
    _socket.onDisconnect((_) => debugPrint("❌ Socket Disconnected"));

    _isInitialized = true;
  }

  void _setupMessageListener() {
    print("🔥 Setting up global message listener in SocketService");
    _socket.on("receive_message", (data) {
      print("🔥 Global message received: $data");
      
      // 🔥 Increase unread count only if user is not in Inbox tab
      try {
        final mainNav = getIt<MainNavViewModel>();
        print("🔥 Current selected index: ${mainNav.selectedIndex}");
        if (mainNav.selectedIndex != 1) {
          print("🔥 Incrementing unread count. Current count: ${mainNav.unreadCount}");
          mainNav.incrementUnread();
          print("🔥 New unread count: ${mainNav.unreadCount}");
        } else {
          print("🔥 User is in inbox tab, not incrementing counter");
        }
      } catch (e) {
        print("🔥 Error accessing MainNavViewModel: $e");
      }
    });
    print("🔥 Global socket listener setup complete");
  }

  void dispose() {
    _socket.disconnect();
    _socket.destroy();
  }
}
