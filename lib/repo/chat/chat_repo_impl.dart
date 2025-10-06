import 'package:be_life_style/config/api_endpoints.dart';
import 'package:be_life_style/data/network/base_api_services.dart';
import 'package:be_life_style/model/chat_list_model/chat_list_model.dart';
import 'package:be_life_style/model/message_model/message_model.dart';
import 'package:be_life_style/repo/chat/chat_repo.dart';

class ChatRepoImpl implements ChatRepo{
  ChatRepoImpl({required this.apiService});
  final BaseApiService apiService;
  @override
  Future<List<ChatListModel>> fetchChatList({required String token}) async{
 try{
  final response= await apiService.getApi(url: ApiEndpoints.fetchChatList,token: token);
  List<ChatListModel> chatList=(response['messages']as List).map((messages)=>ChatListModel.fromJson(messages)).toList();
 return chatList;
 }catch(e){
   rethrow;
 }
  }

  @override
  Future<List<MessageModel>> fetchChatMessages({required int id,required String token,required int page}) async{
    try{
      final response= await apiService.getApi(url:"${ApiEndpoints.fetchChatMessages}/$id?page=$page",token: token);
      List<MessageModel> messagesList=(response['messages']as List).map((messages)=>MessageModel.fromJson(messages)).toList();
      return messagesList;
    }catch(e){
      rethrow;
    }
  }

}