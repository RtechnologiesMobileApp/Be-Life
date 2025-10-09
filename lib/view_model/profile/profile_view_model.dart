import 'dart:developer';
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/model/user_model/user_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/services/cloudinary/cloudinary_services.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/services/socket/socket_service.dart';
import 'package:be_life_style/utils/image_picker_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ProfileViewModel with ChangeNotifier{
  ProfileViewModel({required this.userRepo,required this.cloudinaryServices,required this.imagePickerUtils});

  final UserRepo userRepo;
  final CloudinaryServices cloudinaryServices;
  final ImagePickerUtils imagePickerUtils;
   UserModel? _userDetails;
   UserModel? get userDetails=>_userDetails;
  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;
  int _selectedIndex = 0;
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  int get selectedIndex=>_selectedIndex;

  void setLoading(bool val){
    _isLoading=val;
    notifyListeners();
  }

  void changeTab(int index){
    _selectedIndex=index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

Future<void> fetchUserDetails(BuildContext context) async {
  setLoading(true);
  try {
    // 1️⃣ Get token from SessionController (not user data)
    final token = SessionController().token;

    // 2️⃣ Fetch latest user from backend
    final fetchedUser = await userRepo.getUserDetails(token);

    // 3️⃣ Log fetched bio to confirm
    log("✅ BIO fetched from BE: ${fetchedUser.bio}");

    // 4️⃣ Update local variable and preferences
    _userDetails = fetchedUser;
    await SessionController().saveUserIdInPreference(fetchedUser.id);
    SessionController().bio = fetchedUser.bio ?? '';

    // 5️⃣ Initialize socket after data update
    SocketService().initSocket(fetchedUser.id);

    // 6️⃣ Notify UI
    notifyListeners();
  } catch (e, st) {
    log("❌ fetchUserDetails error: $e");
    log("Stack: $st");
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteName.loginScreen,
        (route) => false,
      );
    }
  } finally {
    setLoading(false);
  }
}

  // Future<void> fetchUserDetails(BuildContext context)async{
  //  setLoading(true);
  //   try{
  //    await SessionController().getUserInPreference();
  //    _userDetails=  await userRepo.getUserDetails(SessionController().token);
  //    SocketService().initSocket(_userDetails!.id);
  //    await SessionController().saveUserIdInPreference(_userDetails!.id);

  //    notifyListeners();
  //   }catch(e){
  //     if(context.mounted) {
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, RouteName.loginScreen, (route) => false);
  //     }
  //     log(e.toString());
  //   }finally{
  //     setLoading(false);
  //   }
  // }


Future<void> updateProfilePic(BuildContext context)async{
    try{
    XFile? image=  await imagePickerUtils.pickImageFromGallery();
    if(image!=null) {
   String? imageUrl= await cloudinaryServices.uploadFile(image);
     if(imageUrl!=null){
       await userRepo.updateProfile({"profilePicture": imageUrl,},SessionController().token);
      if(context.mounted) {
        await fetchUserDetails(context);
      }
     }

    } }catch(e){
      log(e.toString());
    }
  }
  
  Future<void> refreshUserDetails() async {
    try {
      await SessionController().getUserInPreference();
      _userDetails = await userRepo.getUserDetails(SessionController().token);
      notifyListeners();
    } catch (e) {
      log('Error refreshing user details: $e');
    }
  }
  
  void updateLikesCount(int newCount) {
    if (_userDetails != null) {
      _userDetails = _userDetails!.copyWith(likesCount: newCount);
      notifyListeners();
    }
  }

  Future<void> updateProfileFields({
    required BuildContext context,
    String? fullName,
    String? username,
    String? bio,
    String? password,
  }) async {
    try {
      setLoading(true);
      log('[updateProfileFields] incoming values -> fullName: ${fullName ?? '(null)'} | username: ${username ?? '(null)'} | bio: ${bio ?? '(null)'}');
      final Map<String, dynamic> updateData = {};

      if (fullName != null && fullName.trim().isNotEmpty) {
        final parts = fullName.trim().split(RegExp(r"\s+"));
        final String firstName = parts.isNotEmpty ? parts.first : '';
        final String lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
        log('[updateProfileFields] parsed -> firstName: "$firstName" | lastName: "$lastName"');
        if (firstName.isNotEmpty) updateData['firstName'] = firstName;
        if (lastName.isNotEmpty) updateData['lastName'] = lastName;
      }

      if (username != null && username.trim().isNotEmpty) {
        final rawUsername = username.trim();
        final sanitizedUsername = rawUsername.replaceAll(' ', '').toLowerCase();
        log('[updateProfileFields] username raw: "$rawUsername" -> sanitized: "$sanitizedUsername"');
        if (sanitizedUsername.isNotEmpty) {
          updateData['username'] = sanitizedUsername;
        }
      }

      if (bio != null && bio.trim().isNotEmpty) {
        updateData['bio'] = bio.trim();
      }

      final Map<String, dynamic> safeLogData = Map<String, dynamic>.from(updateData);
      if (safeLogData.containsKey('password')) {
        final String pwd = safeLogData['password']?.toString() ?? '';
        safeLogData['password'] = '*** (len=${pwd.length})';
      }
      log('[updateProfileFields] assembled updateData: ' + safeLogData.toString());
      if (password != null && password.trim().isNotEmpty) {
        updateData['password'] = password.trim();
      }

      if (updateData.isEmpty) {
        setLoading(false);
        return;
      }

      final String token = SessionController().token;
      log('[updateProfileFields] sending update with token prefix: ' + (token.isNotEmpty ? token.substring(0, token.length.clamp(0, 12)) + '...' : '(empty)'));
      await userRepo.updateProfile(updateData, token);
      if (context.mounted) {
        await fetchUserDetails(context);
        // Notify user on success
        try {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        } catch (_) {}
      }
    } catch (e) {
      log('Error updating profile fields: $e');
    } finally {
      setLoading(false);
    }
  }
}

 