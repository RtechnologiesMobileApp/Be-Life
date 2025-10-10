import 'package:be_life_style/model/user_model/user_model.dart';

abstract class AuthRepo{
  Future<String> register(UserModel userDetails);
  Future<String> login({required String email,required String pass});
  Future<void> sendOtp({required String email});
  Future<bool> verifyOtp({required String email, required String otp});
}