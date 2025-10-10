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
  // OTP state
  final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());
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
  bool get isOtpExpired => _seconds <= 0;
  @override
  void dispose() {
    passController.dispose();
    emailController.dispose();
    cPassController.dispose();
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNoController.dispose();
    for (final c in otpControllers) { c.dispose(); }
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

  void resetAndStartTimer({int seconds = 120}) {
    _timer?.cancel();
    _seconds = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  String get formattedTime {
    int minutes = _seconds ~/ 60;
    int remainingSeconds = _seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String get enteredOtp => otpControllers.map((c) => c.text).join();

  Future<void> requestOtp(BuildContext context) async {
    validateForm();
    if (emailError != null) {
      FLushBarHelper.flushBarErrorMessage(emailError!, context, FlushbarPosition.TOP);
      return;
    }
    setLoading(true);
    try {
      final email = emailController.text.trim();
      log('[SignupViewModel.requestOtp] email=$email');
      await authServices.sendOtp(email: email);
      resetAndStartTimer(seconds: 120);
      Navigator.pushNamed(context, RouteName.codeInputScreen);
    } catch (e) {
      log('[SignupViewModel.requestOtp] Error: $e');
      FLushBarHelper.flushBarErrorMessage(e.toString(), context, FlushbarPosition.TOP);
    } finally {
      setLoading(false);
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    if (!isOtpExpired) {
      log('[SignupViewModel.resendOtp] blocked: timer not expired');
      return; // prevent spamming before expiry
    }
    try {
      final email = emailController.text.trim();
      log('[SignupViewModel.resendOtp] email=$email');
      await authServices.sendOtp(email: email);
      resetAndStartTimer(seconds: 120);
    } catch (e) {
      log('[SignupViewModel.resendOtp] Error: $e');
      FLushBarHelper.flushBarErrorMessage(e.toString(), context, FlushbarPosition.TOP);
    }
  }

  Future<void> confirmOtpAndProceed(BuildContext context) async {
    if (enteredOtp.length != 6) {
      FLushBarHelper.flushBarErrorMessage("Enter 6 digit code", context, FlushbarPosition.TOP);
      return;
    }
    if (isOtpExpired) {
      FLushBarHelper.flushBarErrorMessage("Code expired. Resend to get a new one.", context, FlushbarPosition.TOP);
      return;
    }
    setLoading(true);
    try {
      final email = emailController.text.trim();
      final otp = enteredOtp;
      log('[SignupViewModel.confirmOtpAndProceed] email=$email otp=$otp');
      final ok = await authServices.verifyOtp(email: email, otp: otp);
      if (ok) {
        stopTimer();
        if (context.mounted) {
          Navigator.pushNamed(context, RouteName.nameInputScreen);
        }
      } else {
        if (context.mounted) {
          FLushBarHelper.flushBarErrorMessage("Invalid code", context, FlushbarPosition.TOP);
        }
      }
    } catch (e) {
      if (context.mounted) {
        FLushBarHelper.flushBarErrorMessage(e.toString(), context, FlushbarPosition.TOP);
      }
    } finally {
      setLoading(false);
    }
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