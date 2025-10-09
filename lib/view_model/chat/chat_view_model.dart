import 'dart:developer';
import 'package:be_life_style/model/chat_list_model/chat_list_model.dart';
import 'package:be_life_style/model/message_model/message_model.dart';
import 'package:be_life_style/repo/chat/chat_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../services/socket/chat_socket_service.dart';

class ChatViewModel with ChangeNotifier {
  ChatViewModel({required this.chatSocketService, required this.chatRepo}) {
    fetchChatList();
    if (!_isSocketListenerSetup) {
      listenReceiveMessage();
      _isSocketListenerSetup = true;
    }
  }

  final ChatSocketService chatSocketService;
  final ChatRepo chatRepo;
  final messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _isSocketListenerSetup = false;
  bool get isLoading => _isLoading;
  bool _hasMore = true;
  bool _isFetchingMore = false;
  int _currentPage = 0;

  // Core data
  final List<ChatListModel> _chatList = [];
  List<ChatListModel> get chatList => _chatList;

  List<ChatListModel> _searchedChatList = [];
  List<ChatListModel> get searchedChatList => _searchedChatList;

  ChatListModel? _activeChat; // currently opened chat
  ChatListModel? get activeChat => _activeChat;

  // fallback getter for UI compatibility
  List<MessageModel> get messages => _activeChat?.messages ?? [];

  ScrollController get scrollController => _scrollController;

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // 🌐 FETCH CHAT LIST
  Future<void> fetchChatList() async {
    setLoading(true);
    try {
      final fetchedChatList = await chatRepo.fetchChatList(
        token: SessionController().token,
      );

      _chatList
        ..clear()
        ..addAll(fetchedChatList);

      notifyListeners();
    } catch (e) {
      log("🚨 CHAT_DEBUG: fetchChatList failed: $e");
    } finally {
      setLoading(false);
    }
  }

  // 📩 FETCH MESSAGES for a specific chat
  Future<void> fetchMessages(int chatId) async {
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Fetching messages for chatId: $chatId");
    _currentPage = 0;
    _hasMore = true;

    setLoading(true);
    try {
      final fetchedMessages = await chatRepo.fetchChatMessages(
        id: chatId,
        token: SessionController().token,
        page: _currentPage,
      );

      final chatIndex = _chatList.indexWhere((c) => c.chatWith == chatId);
      await fetchChatList();
      if (chatIndex != -1) {
        final updated = _chatList[chatIndex].copyWith(
          messages: fetchedMessages,
        );
        _chatList[chatIndex] = updated;
        _activeChat = updated;
      }

      chatSocketService.openChat(otherUserId: chatId);
      notifyListeners();
    } catch (e) {
      log("🚨 CHAT_DEBUG: fetchMessages failed: $e");
    } finally {
      setLoading(false);
    }
  }

  // 💬 LISTEN for incoming messages
  void listenReceiveMessage() {
    print("🔵 CHAT_DEBUG: Setting up receive message listener");
    chatSocketService.onReceiveMessage((newMessage) {
      print("🔵 CHAT_DEBUG: Received new message: $newMessage");
      try {
        final message = MessageModel.fromJson(newMessage);

        // Identify which chat this message belongs to
        final chatId =
            message.senderId == SessionController().id
                ? message.receiverId
                : message.senderId;

        final chatIndex = _chatList.indexWhere((c) => c.chatWith == chatId);
        if (chatIndex != -1) {
          final chat = _chatList[chatIndex];

          // Prevent duplicates
          final alreadyExists =
              chat.messages?.any((m) => m.id == message.id) ?? false;
          if (alreadyExists) return;

          final updatedMessages = [...?chat.messages, message];
          updatedMessages.sort(
            (a, b) => (a.createdAt ?? DateTime.now()).compareTo(
              b.createdAt ?? DateTime.now(),
            ),
          );

          // Update chat with latest message + message list
          final updatedChat = chat.copyWith(
            messages: updatedMessages,
            lastMessage: message.content,
            lastMessageTime:
                message.createdAt?.toIso8601String() ??
                DateTime.now().toIso8601String(),
            unreadCount:
                chatId == _activeChat?.chatWith ? 0 : chat.unreadCount + 1,
          );

          _chatList[chatIndex] = updatedChat;

          // If it’s the active chat, update local reference
          if (_activeChat?.chatWith == chatId) {
            _activeChat = updatedChat;
            scrollToBottom();
          }

          // Move chat to top of list (latest first)
          _chatList.sort(
            (a, b) => b.lastMessageTime.compareTo(a.lastMessageTime),
          );

          notifyListeners();
        } else {
          print("⚠️ CHAT_DEBUG: Message belongs to unknown chatId $chatId");
        }
      } catch (e) {
        log("🚨 CHAT_DEBUG: Error parsing received message: $e");
      }
    });
  }

  // ✉️ SEND MESSAGE
  void sendMessage(int receiverId) {
    final content = messageController.text.trim();
    if (content.isEmpty) return;

    final newMsg = MessageModel(
      senderId: SessionController().id!,
      receiverId: receiverId,
      content: content,
      createdAt: DateTime.now(),
    );

    final chatIndex = _chatList.indexWhere((c) => c.chatWith == receiverId);
    if (chatIndex != -1) {
      final chat = _chatList[chatIndex];
      final updatedMessages = [...?chat.messages];

      final updatedChat = chat.copyWith(
        messages: updatedMessages,
        lastMessage: content,
        lastMessageTime: DateTime.now().toIso8601String(),
      );

      _chatList[chatIndex] = updatedChat;
      _activeChat = updatedChat;
    }

    notifyListeners();
    scrollToBottom();

    chatSocketService.sendMessage(receiverId: receiverId, content: content);
    messageController.clear();
  }

  // 🔄 SORT CHATS BY LATEST MESSAGE TIME
  void sortChatsByLatest() {
    _chatList.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    notifyListeners();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void searchChat(String query) {
    final lower = query.toLowerCase();
    _searchedChatList =
        _chatList
            .where(
              (chat) => chat.chatWithUsername.toLowerCase().contains(lower),
            )
            .toList();
    notifyListeners();
  }

  String convertTime(String time) {
    final convertedTime = DateTime.parse(time);
    return timeago.format(convertedTime);
  }

  // Handle typing indicators
  void startTyping(int toUserId) {
    print(
      "🔵 CHAT_DEBUG [VIEWMODEL]: Starting typing indicator for toUserId: $toUserId",
    );
    chatSocketService.sendTyping(toUserId: toUserId);
  }

  void stopTyping(int toUserId) {
    print(
      "🔵 CHAT_DEBUG [VIEWMODEL]: Stopping typing indicator for toUserId: $toUserId",
    );
    chatSocketService.stopTyping(toUserId: toUserId);
  }

  // Listen for typing indicators from other users
  void setupTypingListeners(
    Function(dynamic) onTyping,
    Function(dynamic) onStopTyping,
  ) {
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Setting up typing listeners");
    chatSocketService.onTyping(onTyping);
    chatSocketService.onStopTyping(onStopTyping);
  }

  // Mark messages as read when chat is visible
  void markAsRead(int otherUserId) {
    print(
      "🔵 CHAT_DEBUG [VIEWMODEL]: Marking messages as read for otherUserId: $otherUserId",
    );
    chatSocketService.markMessagesAsRead(otherUserId: otherUserId);

    // Also reset unreadCount locally
    final chatIndex = _chatList.indexWhere((c) => c.chatWith == otherUserId);
    if (chatIndex != -1) {
      final updatedChat = _chatList[chatIndex].copyWith(unreadCount: 0);
      _chatList[chatIndex] = updatedChat;
      if (_activeChat?.chatWith == otherUserId) {
        _activeChat = updatedChat;
      }
      notifyListeners();
    }
  }

  // Attach scroll listener to fetch more messages
  void attachScrollListener(int chatId) {
    if (!_scrollController.hasListeners) {
      _scrollController.addListener(() {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent - 100) {
          final chat = _chatList.firstWhere((c) => c.chatWith == chatId);
          if (chat != null && _hasMore && !_isFetchingMore) {
            // fetchMoreMessages(chatId);
          }
        }
      });
    }
  }

  // Fetch more messages for a chat
  Future<void> fetchMoreMessages(int chatId) async {
    if (_isFetchingMore || !_hasMore) return;
    _isFetchingMore = true;

    try {
      final fetchedMessages = await chatRepo.fetchChatMessages(
        id: chatId,
        token: SessionController().token,
        page: _currentPage + 1,
      );

      if (fetchedMessages.isEmpty) {
        _hasMore = false;
      } else {
        _currentPage++;

        final chatIndex = _chatList.indexWhere((c) => c.chatWith == chatId);
        if (chatIndex != -1) {
          final chat = _chatList[chatIndex];
          final updatedMessages = [...?chat.messages, ...fetchedMessages];
          final updatedChat = chat.copyWith(messages: updatedMessages);
          _chatList[chatIndex] = updatedChat;

          if (_activeChat?.chatWith == chatId) {
            _activeChat = updatedChat;
          }
        }

        notifyListeners();
      }
    } catch (e) {
      log("Error loading more messages: $e");
    } finally {
      _isFetchingMore = false;
    }
  }
}
