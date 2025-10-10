import 'package:be_life_style/config/api_endpoints.dart';
import 'package:be_life_style/data/network/base_api_services.dart';
import 'package:be_life_style/model/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final BaseApiService apiService;
  AuthRepoImpl({required this.apiService});

  @override
  Future<String> login({required String email, required String pass}) async {
    try {
      final response = await apiService.postApi(
        url: ApiEndpoints.signIn,
        data: {"email": email, "password": pass},
      );
      return response['token'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> register(UserModel userDetails) async {
    try {
      final response = await apiService.postApi(
        url: ApiEndpoints.signup,
        data: userDetails.toJson(),
      );
      return response['token'];
    } catch (e) {
      debugPrint("ERROR DURING REGISTRATION : $e");
      rethrow;
    }
  }

  @override
  Future<void> sendOtp({required String email}) async {
    try {
      final url = ApiEndpoints.sendOtp;
      final payload = {"email": email};
      log('[AuthRepoImpl.sendOtp] POST $url');
      log('[AuthRepoImpl.sendOtp] Payload: $payload');
      final response = await apiService.postApi(
        url: url,
        data: payload,
      );
      log('[AuthRepoImpl.sendOtp] Response: $response');
    } catch (e) {
      log('[AuthRepoImpl.sendOtp] Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> verifyOtp({required String email, required String otp}) async {
    try {
      final url = ApiEndpoints.verifyOtp;
      final payload = {"email": email, "otp": otp};
      log('[AuthRepoImpl.verifyOtp] POST $url');
      log('[AuthRepoImpl.verifyOtp] Payload: $payload');
      final response = await apiService.postApi(
        url: url,
        data: payload,
      );
      log('[AuthRepoImpl.verifyOtp] Response: $response');
      return response['verified'] == true;
    } catch (e) {
      log('[AuthRepoImpl.verifyOtp] Error: $e');
      rethrow;
    }
  }
}
