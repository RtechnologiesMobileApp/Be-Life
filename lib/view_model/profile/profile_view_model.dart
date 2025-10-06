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
}