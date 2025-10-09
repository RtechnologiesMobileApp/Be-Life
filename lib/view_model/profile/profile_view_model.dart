import 'dart:developer';
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/model/user_model/user_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/services/cloudinary/cloudinary_services.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/services/socket/socket_service.dart';
import 'package:be_life_style/utils/image_picker_utils.dart';
import 'package:flutter/widgets.dart';
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

  Future<void> fetchUserDetails(BuildContext context)async{
   setLoading(true);
    try{
     await SessionController().getUserInPreference();
     _userDetails=  await userRepo.getUserDetails(SessionController().token);
     SocketService().initSocket(_userDetails!.id);
     await SessionController().saveUserIdInPreference(_userDetails!.id);

     notifyListeners();
    }catch(e){
      if(context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.loginScreen, (route) => false);
      }
      log(e.toString());
    }finally{
      setLoading(false);
    }
  }
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
        updateData['username'] = username.trim();
      }

      if (bio != null && bio.trim().isNotEmpty) {
        updateData['bio'] = bio.trim();
      }

      log('[updateProfileFields] assembled updateData: ' + updateData.toString());
      if (updateData.isEmpty) {
        setLoading(false);
        return;
      }

      final String token = SessionController().token;
      log('[updateProfileFields] sending update with token prefix: ' + (token.isNotEmpty ? token.substring(0, token.length.clamp(0, 12)) + '...' : '(empty)'));
      await userRepo.updateProfile(updateData, token);
      if (context.mounted) {
        await fetchUserDetails(context);
      }
    } catch (e) {
      log('Error updating profile fields: $e');
    } finally {
      setLoading(false);
    }
  }
}

 
// import 'dart:developer';
// import 'package:be_life_style/config/routes/route_names.dart';
// import 'package:be_life_style/model/user_model/user_model.dart';
// import 'package:be_life_style/repo/user/user_repo.dart';
// import 'package:be_life_style/services/cloudinary/cloudinary_services.dart';
// import 'package:be_life_style/services/session_manager/session_controller.dart';
// import 'package:be_life_style/services/socket/socket_service.dart';
// import 'package:be_life_style/utils/image_picker_utils.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';


// class ProfileViewModel with ChangeNotifier{
//   ProfileViewModel({required this.userRepo,required this.cloudinaryServices,required this.imagePickerUtils});

//   final UserRepo userRepo;
//   final CloudinaryServices cloudinaryServices;
//   final ImagePickerUtils imagePickerUtils;
//    UserModel? _userDetails;
//    UserModel? get userDetails=>_userDetails;
//   final PageController _pageController = PageController(initialPage: 0);
//   PageController get pageController => _pageController;
//   int _selectedIndex = 0;
//   bool _isLoading=false;
//   bool get isLoading=>_isLoading;
//   int get selectedIndex=>_selectedIndex;

//   void setLoading(bool val){
//     _isLoading=val;
//     notifyListeners();
//   }

//   void changeTab(int index){
//     _selectedIndex=index;
//     pageController.animateToPage(
//       index,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//     notifyListeners();
//   }

//   Future<void> fetchUserDetails(BuildContext context)async{
//    setLoading(true);
//     try{
//      await SessionController().getUserInPreference();
//      _userDetails=  await userRepo.getUserDetails(SessionController().token);
//      SocketService().initSocket(_userDetails!.id);
//      await SessionController().saveUserIdInPreference(_userDetails!.id);

//      notifyListeners();
//     }catch(e){
//       if(context.mounted) {
//         Navigator.pushNamedAndRemoveUntil(
//             context, RouteName.loginScreen, (route) => false);
//       }
//       log(e.toString());
//     }finally{
//       setLoading(false);
//     }
//   }
// Future<void> updateProfilePic(BuildContext context)async{
//     try{
//     XFile? image=  await imagePickerUtils.pickImageFromGallery();
//     if(image!=null) {
//    String? imageUrl= await cloudinaryServices.uploadFile(image);
//      if(imageUrl!=null){
//        await userRepo.updateProfile({"profilePicture": imageUrl,},SessionController().token);
//       if(context.mounted) {
//         await fetchUserDetails(context);
//       }
//      }

//     } }catch(e){
//       log(e.toString());
//     }
//   }
  
//   Future<void> refreshUserDetails() async {
//     try {
//       await SessionController().getUserInPreference();
//       _userDetails = await userRepo.getUserDetails(SessionController().token);
//       notifyListeners();
//     } catch (e) {
//       log('Error refreshing user details: $e');
//     }
//   }
  
//   void updateLikesCount(int newCount) {
//     if (_userDetails != null) {
//       _userDetails = _userDetails!.copyWith(likesCount: newCount);
//       notifyListeners();
//     }
//   }
// }