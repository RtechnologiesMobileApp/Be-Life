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
    listenReceiveMessage();
  }
  final messageController=TextEditingController();
  final ChatSocketService chatSocketService;
  final ChatRepo chatRepo;
  bool _isLoading=false;
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
    chatSocketService.onReceiveMessage((newMessage) {
      log("New message received: $newMessage");

      try {
        final message = MessageModel.fromJson(newMessage);
        scrollToBottom();
        _messages.insert(0,message);

        notifyListeners();
      } catch (e) {
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
    _currentPage = 0;
    _hasMore = true;
    _messages.clear();
    setLoading(true);
    try{
    _messages.clear();
    final fetchedMessages=  await chatRepo.fetchChatMessages(id: id, token: SessionController().token,page: _currentPage);
    _messages.addAll(fetchedMessages);
    notifyListeners();

    }catch(e){
      log(e.toString());
    }finally{
      setLoading(false);
    }
  }

  void sendMessage(int receiverId){
    MessageModel newMsg=MessageModel(senderId: SessionController().id!, receiverId: receiverId, content: messageController.text,);
    scrollToBottom();

    _messages.insert(0,newMsg);
   chatSocketService.sendMessage(senderId: SessionController().id!, receiverId: receiverId, content: messageController.text,);
   messageController.clear();
    notifyListeners();

  }

}