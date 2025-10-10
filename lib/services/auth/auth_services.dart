import 'package:be_life_style/repo/auth/auth_repo.dart';
import 'package:be_life_style/services/cloudinary/cloudinary_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/user_model/user_model.dart';
import '../session_manager/session_controller.dart';
import 'dart:developer';

class AuthServices {
  AuthServices({required this.authRepo, required this.cloudinaryService});
  final AuthRepo authRepo;
  final CloudinaryServices cloudinaryService;

  Future<void> login({required String email, required String pass}) async {
    try {
      final String authToken = await authRepo.login(email: email, pass: pass);
      await SessionController().saveUserInPreference(authToken);
      debugPrint("$authToken saved to secure storage");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createAccount({
    required UserModel userDetails,
    XFile? profilePic,
  }) async {
    try {
      log('Starting account creation process...');

      String? imageUrl;
      if (profilePic != null) {
        log('Profile picture provided, uploading to Cloudinary...');
        log('Profile picture path: ${profilePic.path}');

        imageUrl = await cloudinaryService.uploadFile(profilePic);
        log('Cloudinary upload result: $imageUrl');

        if (imageUrl == null) {
          log(
            'Profile picture upload failed, proceeding without profile picture',
          );
        } else {
          log('Profile picture uploaded successfully');
        }
      } else {
        log('No profile picture provided, proceeding without profile picture');
      }

      // Create user with or without profile picture
      // final userToRegister = profilePic != null && imageUrl != null
      //     ? userDetails.copyWith(profilePicture: imageUrl)
      //     : userDetails.copyWith(profilePicture: "https://via.placeholder.com/150?text=No+Image");

      // ✅ Always provide a valid URL (either uploaded one or placeholder)
      final userToRegister = userDetails.copyWith(
        bio: "nothing",
        profilePicture:
            imageUrl ?? "https://via.placeholder.com/150?text=No+Image",
      );

      log('Proceeding with user registration...');
      log("USER TO REGISTER ${userToRegister.toJson()}");
      final String authToken = await authRepo.register(userToRegister);
      log(
        'User registration successful, token received: ${authToken.substring(0, 20)}...',
      );

      await SessionController().saveUserInPreference(authToken);
      debugPrint("$authToken saved to secure storage");
    } catch (e) {
      log('Error in createAccount: $e');
      rethrow;
    }
  }

  Future<void> sendOtp({required String email}) async {
    try {
      log('[AuthServices.sendOtp] email=$email');
      await authRepo.sendOtp(email: email);
      log('[AuthServices.sendOtp] OK');
    } catch (e) {
      log('[AuthServices.sendOtp] Error: $e');
      rethrow;
    }
  }

  Future<bool> verifyOtp({required String email, required String otp}) async {
    try {
      log('[AuthServices.verifyOtp] email=$email otp=$otp');
      final ok = await authRepo.verifyOtp(email: email, otp: otp);
      log('[AuthServices.verifyOtp] verified=$ok');
      return ok;
    } catch (e) {
      log('[AuthServices.verifyOtp] Error: $e');
      rethrow;
    }
  }
}
