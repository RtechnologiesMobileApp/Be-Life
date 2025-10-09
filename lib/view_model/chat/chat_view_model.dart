import 'dart:developer';
import 'package:be_life_style/model/chat_list_model/chat_list_model.dart';
import 'package:be_life_style/model/message_model/message_model.dart';
import 'package:be_life_style/repo/chat/chat_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../services/socket/chat_socket_service.dart';

class ChatViewModel with ChangeNotifier{
  ChatViewModel({required this.chatSocketService,required this.chatRepo}){
    _fetchChatList();
    // Only set up socket listener once
    if (!_isSocketListenerSetup) {
      listenReceiveMessage();
      _isSocketListenerSetup = true;
    }
  }
  final messageController=TextEditingController();
  final ChatSocketService chatSocketService;
  final ChatRepo chatRepo;
  bool _isLoading=false;
  bool _isSocketListenerSetup = false;
  bool get isLoading=>_isLoading;
  int _currentPage = 0;
  bool _hasMore = true;
  bool _isFetchingMore = false;
final List<ChatListModel> _chatList=[];
 List<ChatListModel> get chatList =>_chatList;
   List<ChatListModel> _searchedChatList=[];
 List<ChatListModel> get searchedChatList =>_searchedChatList;
final List<MessageModel> _messages=[];
List<MessageModel> get messages=>_messages;
  final ScrollController _scrollController = ScrollController();
ScrollController get scrollController=>_scrollController;
  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void attachScrollListener(int chatId) {
    if (!_scrollController.hasListeners) {
      _scrollController.addListener(() {
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent - 100) {
          if (_hasMore && !_isFetchingMore) {
            fetchMoreMessages(chatId);
          }
        }
      });
    }
  }
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
        _messages.addAll(fetchedMessages);
        notifyListeners();
      }
    } catch (e) {
      log("Error loading more messages: $e");
    } finally {
      _isFetchingMore = false;
    }
  }
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
      0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }}

  void setLoading(bool val){
    _isLoading=val;
    notifyListeners();
  }

  void listenReceiveMessage() {
    print("🔵 CHAT_DEBUG: Setting up receive message listener");
    chatSocketService.onReceiveMessage((newMessage) {
      print("🔵 CHAT_DEBUG: Received new message: $newMessage");
      try {
        final message = MessageModel.fromJson(newMessage);
        print("🔵 CHAT_DEBUG: Parsed message successfully, adding to list");
        scrollToBottom();
        _messages.insert(0,message);
        print("🔵 CHAT_DEBUG: Message added, total messages: ${_messages.length}");
        notifyListeners();
      } catch (e) {
        print("🔵 CHAT_DEBUG: Error parsing received message: $e");
        log("Error parsing received message: $e");
      }
    });
  }

  void searchChat(String text){
    final query = text.toLowerCase();
    _searchedChatList= _chatList.where((chat) =>
          chat.chatWithUsername.toLowerCase().contains(query)).toList();

    notifyListeners();
  }
  String convertTime(String time){
    final convertedTime = DateTime.parse(time);
    return timeago.format(convertedTime);
  }
  Future<void> _fetchChatList()async{
    setLoading(true);
    try{
      final fetchedChatList=  await chatRepo.fetchChatList(token: SessionController().token);
      _chatList.addAll(fetchedChatList);
      notifyListeners();
    }catch(e){
      log(e.toString());
    }finally{
      setLoading(false);
    }
  }
  Future<void> fetchMessages(int id)async{
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Starting fetchMessages for chatId: $id");
    _currentPage = 0;
    _hasMore = true;
    _messages.clear();
    setLoading(true);
    try{
    _messages.clear();
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Fetching messages from API for chatId: $id, page: $_currentPage");
    final fetchedMessages=  await chatRepo.fetchChatMessages(id: id, token: SessionController().token,page: _currentPage);
    print("🔵 CHAT_DEBUG [VIEWMODEL]: API returned ${fetchedMessages.length} messages");
    _messages.addAll(fetchedMessages);
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Total messages in list: ${_messages.length}");
    
    // Emit open_chat event to join the chat room
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Emitting open_chat event for otherUserId: $id");
    chatSocketService.openChat(otherUserId: id);
    
    // Listen for chat history from socket
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Setting up chat_history listener");
    chatSocketService.onChatHistory((chatHistory) {
      print("🔵 CHAT_DEBUG [VIEWMODEL]: Received chat history from socket: $chatHistory");
      // Handle chat history if needed
    });
    
    notifyListeners();
    print("🔵 CHAT_DEBUG [VIEWMODEL]: fetchMessages completed successfully");

    }catch(e){
      print("🔵 CHAT_DEBUG [VIEWMODEL]: Error in fetchMessages: ${e.toString()}");
      log(e.toString());
    }finally{
      setLoading(false);
      print("🔵 CHAT_DEBUG [VIEWMODEL]: fetchMessages finished, loading set to false");
    }
  }

  void sendMessage(int receiverId){
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Sending message to receiverId: $receiverId, content: ${messageController.text}");
    MessageModel newMsg=MessageModel(senderId: SessionController().id!, receiverId: receiverId, content: messageController.text,);
    scrollToBottom();

    _messages.insert(0,newMsg);
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Message added to local list, total messages: ${_messages.length}");
    
    // Send message via socket with corrected parameters
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Emitting send_message event via socket");
    chatSocketService.sendMessage(receiverId: receiverId, content: messageController.text);
    
    // Listen for message sent confirmation
    chatSocketService.onMessageSent((sentMessage) {
      print("🔵 CHAT_DEBUG [VIEWMODEL]: Message sent confirmation received: $sentMessage");
      // Update message status if needed
    });
    
    messageController.clear();
    notifyListeners();
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Send message completed");
  }

  // Mark messages as read when chat is visible
  void markAsRead(int otherUserId) {
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Marking messages as read for otherUserId: $otherUserId");
    chatSocketService.markMessagesAsRead(otherUserId: otherUserId);
  }

  // Handle typing indicators
  void startTyping(int toUserId) {
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Starting typing indicator for toUserId: $toUserId");
    chatSocketService.sendTyping(toUserId: toUserId);
  }

  void stopTyping(int toUserId) {
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Stopping typing indicator for toUserId: $toUserId");
    chatSocketService.stopTyping(toUserId: toUserId);
  }

  // Listen for typing indicators from other users
  void setupTypingListeners(Function(dynamic) onTyping, Function(dynamic) onStopTyping) {
    print("🔵 CHAT_DEBUG [VIEWMODEL]: Setting up typing listeners");
    chatSocketService.onTyping(onTyping);
    chatSocketService.onStopTyping(onStopTyping);
  }

}