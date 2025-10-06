import 'dart:async';
import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:be_life_style/model/interest_model.dart';
import 'package:be_life_style/model/user_model/user_model.dart';
import 'package:be_life_style/services/auth/auth_services.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/utils/flushbar_helper.dart';
import 'package:be_life_style/utils/form_validator.dart';
import 'package:be_life_style/utils/image_picker_utils.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../config/routes/route_names.dart';

class LoginViewModel with ChangeNotifier{
  final AuthServices authServices;
  final ImagePickerUtils imagePickerUtils;
  LoginViewModel({required this.authServices,required this.imagePickerUtils});
  final emailController= TextEditingController();
  final passController= TextEditingController();
  String? _passError;
  String? _emailError;
  bool _obs=true;
  bool _isLoading=false;
  bool get obs=>_obs;
  bool get isLoading=>_isLoading;
  String? get emailError=>_emailError;
  String? get passError=>_passError;

  void setLoading(bool val){
    _isLoading=val;
    notifyListeners();
  }


  void validateForm() {
    _emailError = FormValidator.validateEmail(emailController.text);
    notifyListeners();
  }

  togglePass(){
    _obs=!_obs;
    print(_obs);
    notifyListeners();
  }
Future<void> login(BuildContext context)async{
    setLoading(true);
    try{
      await authServices.login(email: emailController.text, pass: passController.text);
      if(context.mounted){
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.mainNavScreen, (route) => false);
      }
    }catch(e){
      log(e.toString());
      if(context.mounted){
        FLushBarHelper.flushBarErrorMessage(e.toString(), context);
      }
    }finally{
      setLoading(false);
    }
}
}