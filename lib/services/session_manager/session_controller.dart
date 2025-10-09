
import 'package:flutter/cupertino.dart';
import '../storage/local_storage.dart';

class SessionController{
   static final SessionController _session=SessionController._internal();
  final LocalStorage localStorage=LocalStorage();
  String token='';
  bool? isLoggedin;
  int? id;
  String? bio;
   SessionController._internal(){
    isLoggedin=false;
  }

  factory SessionController(){
    return _session;
  }

  Future<void> saveUserInPreference(String token)async {
  await  localStorage.setValue('token', token);
  await  localStorage.setValue('isLogin', 'true');
  this.token=token;
  }
  Future<void> saveUserIdInPreference(int id)async{
    await  localStorage.setValue('uid', id.toString());
    this.id = id;
  }
   Future<void> getUserInPreference() async {
     try {
       String? userToken = await localStorage.readValue('token');
       String? isLogin = await localStorage.readValue('isLogin');
       String? userId=await localStorage.readValue('uid');
       if (userToken != null && userToken.isNotEmpty) {
         token = userToken;
       }
       if(userId!=null&& userId.isNotEmpty){
         id=int.parse(userId);
       }

     isLoggedin = isLogin == 'true' ? true : false;
     } catch (e) {
       debugPrint(e.toString());
     }
   }
   Future<void> clearSession() async {
     try {
       await localStorage.deleteValue('token');
       await localStorage.deleteValue('isLogin');
      await localStorage.deleteValue('uid');
       token = '';
       isLoggedin = false;
       id=null;

       debugPrint('Session cleared successfully');
     } catch (e) {
       debugPrint('Error while clearing session: $e');
     }
   }

}