import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
class FLushBarHelper{
  static void flushBarErrorMessage(String message, BuildContext context,[FlushbarPosition position=FlushbarPosition.BOTTOM]){
    showFlushbar(context: context,
        flushbar: Flushbar(
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error,color: Colors.white,),
          message: message,
          messageColor: Colors.white,
          forwardAnimationCurve: Curves.bounceIn,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          duration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: position,

        )..show(context));
  }
  static void flushBarSuccessMessage(String message, BuildContext context){
    showFlushbar(context: context,
        flushbar: Flushbar(
          backgroundColor: Colors.green,
          icon: const Icon(Icons.verified,color: Colors.white,),
          message: message,
          messageColor: Colors.white,
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeInOut,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          duration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.BOTTOM,

        )..show(context));
  }
}