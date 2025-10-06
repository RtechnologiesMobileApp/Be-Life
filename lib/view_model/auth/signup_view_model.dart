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
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/routes/route_names.dart';

class SignupViewModel with ChangeNotifier{
  final AuthServices authServices;
  final ImagePickerUtils imagePickerUtils;
  SignupViewModel({required this.authServices,required this.imagePickerUtils});
  final emailController= TextEditingController();
  final passController= TextEditingController();
  final cPassController= TextEditingController();
  final usernameController= TextEditingController();
  final firstNameController= TextEditingController();
  final lastNameController= TextEditingController();
  final phoneNoController= TextEditingController();
  DateTime _dob=DateTime.now();
  final List<String> _selectedInterests=[];
  String? _countryCode;
  String? _firstNameError;
  String? _lastNameError;
  String? _passError;
  String? _emailError;
  String? _phoneNoError;
  String? _userNameError;
  bool _passLengthValid=false;
  bool _isLoading=false;
  bool _lowerUpperCaseValid=false;
  bool _atLeast1Num=false;
  bool _atLeast1Symbol=false;
  bool _obs=true;
  int _seconds = 119;
  XFile? profilePic;
  Timer? _timer;
  List<String> get selectedInterest=>_selectedInterests;
  bool get passLengthValid=>_passLengthValid;
  bool get isLoading=>_isLoading;
  bool get lowerUpperCaseValid=>_lowerUpperCaseValid;
  bool get atLeast1Num=>_atLeast1Num;
  bool get atLeast1Symbol=>_atLeast1Symbol;
  bool get obs=>_obs;
  String? get firstNameError=>_firstNameError;
  String? get lastNameError=>_lastNameError;
  String? get phoneNoError=>_phoneNoError;
  String? get emailError=>_emailError;
  String? get passError=>_passError;
  String? get userNameError=>_userNameError;
  DateTime get dob=>_dob;
  String? get countryCode=>_countryCode;
  int get seconds => _seconds;
  @override
  void dispose() {
    passController.dispose();
    _timer?.cancel();
    super.dispose();
  }
  void setLoading(bool val){
    _isLoading=val;
    notifyListeners();
  }
  void setDob(DateTime val){
    _dob=val;
  }

  void validateForm() {
    _firstNameError = FormValidator.validateFirstName(firstNameController.text);
    _lastNameError = FormValidator.validateLastName(lastNameController.text);
    _emailError = FormValidator.validateEmail(emailController.text);
    _phoneNoError = FormValidator.validatePhoneNo(phoneNoController.text);
    _passError = FormValidator.validatePassword(passController.text,cPassController.text);
    _userNameError = FormValidator.validateUserName(usernameController.text,);
    notifyListeners();
  }

  void startTimer() {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  String get formattedTime {
    int minutes = _seconds ~/ 60;
    int remainingSeconds = _seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  final List<InterestModel> _interests=[
  InterestModel(img: AppImages.placesIcon, title: 'Places', subTitle: 'Locations, restaurants, travel itineraries',isSelected: false),
  InterestModel(img: AppImages.tvIcon, title: 'TV and Movies', subTitle: 'Films, shows and anything entertainment',isSelected: false),
  InterestModel(img: AppImages.booksIcon, title: 'Books', subTitle: 'Reading list, reviews, authors',isSelected: false),
  InterestModel(img: AppImages.musicIcon, title: 'Music', subTitle: 'Artist, songs, album, concerts',isSelected: false),
  InterestModel(img: AppImages.sportsIcon, title: 'Sports', subTitle: 'Locations, restaurants, travel itineraries', isSelected: false,),
  InterestModel(img: AppImages.businessIcon, title: 'Business', subTitle: 'Locations, restaurants, travel itineraries',isSelected: false),
];

List <InterestModel> get interests=>_interests;

void selectInterest(int index){
  _interests[index] = _interests[index].copyWith(isSelected:!_interests[index].isSelected);
  _selectedInterests.add(_interests[index].title);
  notifyListeners();
}
  togglePass(){
    _obs=!_obs;
    notifyListeners();
  }
  void validatePass() {
    String password = passController.text;
    _passLengthValid = password.length >= 8;
    _lowerUpperCaseValid = RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
    _atLeast1Num = RegExp(r'[0-9]').hasMatch(password);
    _atLeast1Symbol = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);
    notifyListeners();
  }

  Future<void> createAccount(BuildContext context)async{
  setLoading(true);
  try{
    final selectedInterestNames = _interests
        .where((interest) => interest.isSelected)
        .map((interest) => interest.title)
        .toList();
    final userDetails= UserModel( 
      username: usernameController.text,
       firstName: firstNameController.text,
        lastName: lastNameController.text,
         email: emailController.text, 
         dob: dob,
          phoneNumber: phoneNoController.text, 
          interests: selectedInterestNames,
           profilePicture: "",
           password: passController.text);
    
    log('Creating account for user: ${userDetails.username}');
    log('User details: ${userDetails.toJson()}');
    
     await authServices.createAccount(userDetails: userDetails, profilePic: profilePic);
    if(context.mounted){
    Navigator.pushNamedAndRemoveUntil(
        context, RouteName.successScreen, (route) => false);
    }

  }catch(e){
    log('Error creating account: $e');
    if(context.mounted){
    FLushBarHelper.flushBarErrorMessage(e.toString(), context);
    }
  }finally{
    setLoading(false);
  }
  }
  Future<void> pickImage(BuildContext context)async{
   try{
     profilePic=await imagePickerUtils.pickImageFromGallery();
     notifyListeners();
   }catch(e){
     if(context.mounted) {
       FLushBarHelper.flushBarErrorMessage(
           "Failed to pick image. Make sure you have given permission",
           context,FlushbarPosition.TOP);
     }
   }
  }
}