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
    });

    _socket.on("connect_error", (err) {
      debugPrint("❌ Connection error: ${err.message}");
    });
    _socket.onDisconnect((_) => debugPrint("❌ Socket Disconnected"));

    _isInitialized = true;
  }

  void dispose() {
    _socket.disconnect();
    _socket.destroy();
  }
}
