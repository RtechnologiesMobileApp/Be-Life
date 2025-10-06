import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../config/routes/route_names.dart';
import '../session_manager/session_controller.dart';

class SplashServices{
  void isLogin(BuildContext context){
    SessionController().getUserInPreference().then((value){
      if(SessionController().isLoggedin??false){
        Timer(Duration(seconds: 3), ()=>Navigator.pushNamedAndRemoveUntil(context, RouteName.mainNavScreen,(route)=>false));
      }
      else{
        Timer(Duration(seconds: 3), ()=>Navigator.pushNamedAndRemoveUntil(context,RouteName.welcomeScreen,(route)=>false));
      }
    }).onError((err,stackTrace){
      Timer(Duration(seconds: 3), ()=>Navigator.pushNamedAndRemoveUntil(context,RouteName.welcomeScreen,(route)=>false));
    });
  }
}