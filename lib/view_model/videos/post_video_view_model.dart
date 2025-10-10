import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:be_life_style/model/user_model/other_user_model.dart';
import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/cloudinary/cloudinary_services.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:be_life_style/utils/image_picker_utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:video_player/video_player.dart';

class PostVideoViewModel with ChangeNotifier{
  PostVideoViewModel({required this.imagePickerUtils,required this.videoRepo,required this.cloudinaryServices});
  final ImagePickerUtils imagePickerUtils;
  final VideoRepo videoRepo;
  final CloudinaryServices cloudinaryServices;
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
   XFile? _pickedVideo;
  XFile ? get pickedVideo=>_pickedVideo;
  Uint8List? _thumbnail;
  String? _thumbnailUrl;
  Uint8List? get thumbnail=>_thumbnail;
  XFile? _customThumbnail;
  XFile ? get customThumbnail=>_customThumbnail;
   String? currentLocation;
  String? placeName; // reverse-geocoded place name
  String? _detectedPlace;
String? get detectedPlace => _detectedPlace;
final captionController=TextEditingController();
bool _visibility=true;
bool get visibility =>_visibility;

// Tagged users functionality
final List<OtherUserModel> _taggedUsers = [];
List<OtherUserModel> get taggedUsers => _taggedUsers;

  void clearData(){
    captionController.clear();
    _pickedVideo=null;
    _thumbnail=null;
    _thumbnailUrl=null;
    _customThumbnail=null;
    _visibility=true;
    _taggedUsers.clear();
    notifyListeners();
  }
  void setLoading(bool val){
    _isLoading=val;
    notifyListeners();
  }

  void toggleVisibility(){
    _visibility=!_visibility;
    notifyListeners();
  }

  // Tagged users methods
  void updateTaggedUsers(List<OtherUserModel> users) {
    _taggedUsers.clear();
    _taggedUsers.addAll(users);
    notifyListeners();
  }

  void addTaggedUser(OtherUserModel user) {
    if (!_taggedUsers.any((tagged) => tagged.id == user.id)) {
      _taggedUsers.add(user);
      notifyListeners();
    }
  }

  void removeTaggedUser(OtherUserModel user) {
    _taggedUsers.removeWhere((tagged) => tagged.id == user.id);
    notifyListeners();
  }
Future<void> getCurrentLocation() async {
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final p = placemarks.first;

      // ✅ skip numeric-only names like "14"
      bool isNumeric(String? s) => s != null && RegExp(r'^\d+$').hasMatch(s);

      String? placeName;
      if (p.name != null && p.name!.isNotEmpty && !isNumeric(p.name)) {
        placeName = p.name;
      } else if (p.subLocality != null && p.subLocality!.isNotEmpty) {
        placeName = p.subLocality;
      } else if (p.locality != null && p.locality!.isNotEmpty) {
        placeName = p.locality;
      } else if (p.administrativeArea != null && p.administrativeArea!.isNotEmpty) {
        placeName = p.administrativeArea;
      } else if (p.country != null && p.country!.isNotEmpty) {
        placeName = p.country;
      }

      // ✅ readable tag for UI/backend
      currentLocation = "${p.locality ?? ''}, ${p.country ?? ''}".trim();

      _detectedPlace = placeName;
      notifyListeners();

      debugPrint("📍 Detected place: $placeName");
      debugPrint("🏙️ Detected location: $currentLocation");
    }
  } catch (e) {
    print("❌ Location error: $e");
  }
}

// Future<void> getCurrentLocation() async {
//   try {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return;

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) return;
//     }
//     if (permission == LocationPermission.deniedForever) return;

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       position.latitude,
//       position.longitude,
//     );

//     if (placemarks.isNotEmpty) {
//       final p = placemarks.first;

//       // helper function to check if value is a valid place name
//       bool isValidPlace(String? text) {
//         if (text == null || text.trim().isEmpty) return false;
//         // remove digits and check if still has alphabets
//         final cleaned = text.replaceAll(RegExp(r'[0-9]'), '').trim();
//         return cleaned.isNotEmpty && cleaned.length > 2;
//       }

//       // try best fields
//       String? placeName;
//       if (isValidPlace(p.name)) {
//         placeName = p.name;
//       } else if (isValidPlace(p.street)) {
//         placeName = p.street;
//       } else if (isValidPlace(p.subLocality)) {
//         placeName = p.subLocality;
//       } else if (isValidPlace(p.locality)) {
//         placeName = p.locality;
//       }

//       // City + country
//       currentLocation = "${p.locality ?? ''}, ${p.country ?? ''}".trim();

//       // store both
//       _detectedPlace = placeName;
//       notifyListeners();

//       debugPrint("📍 Detected place (clean): $_detectedPlace");
//       debugPrint("🏙️ Detected location: $currentLocation");
//       debugPrint("🌐 Coordinates: ${position.latitude}, ${position.longitude}");
//     }
//   } catch (e) {
//     debugPrint("❌ Location error: $e");
//   }
// }
    
  Future<void> pickCoverFromGallery()async{
    setLoading(true);
    try{
      _customThumbnail= await imagePickerUtils.pickImageFromGallery();
      notifyListeners();
    }catch(e){
      log(e.toString());
    }finally{
      setLoading(false);
    }
  }
  Future<void> pickVideo()async{
    setLoading(true);
    try{
     _pickedVideo= await imagePickerUtils.pickVideoFromGallery();
     if(_pickedVideo!=null){
      await extractVideoThumbnail(_pickedVideo!);
     }
     notifyListeners();

    }catch(e){
      log(e.toString());
    }finally{
      setLoading(false);
    }
  }
Future<void> extractVideoThumbnail(XFile videoFile)async{
  try{
    _thumbnail = await VideoThumbnail.thumbnailData(
      video: videoFile.path,
      imageFormat: ImageFormat.JPEG,
      quality: 75,
    );

  }catch(e){
    log(e.toString());
  }
}
  Future<Map<String, dynamic>> getVideoMetaData(XFile file) async {
    final controller = VideoPlayerController.file(File(file.path));
    await controller.initialize();

    final Duration duration = controller.value.duration;
    final Size size = controller.value.size;

    controller.dispose();

    return {
      'duration': duration.inSeconds,
      'width': size.width.toInt(),
      'height': size.height.toInt(),
      'resolution': '${size.width.toInt()}x${size.height.toInt()}',
      'ratio': (size.width / size.height).toStringAsFixed(2)
    };
  }

Future<void> postVideo()async{
    setLoading(true);
    try{
     String? videoUrl= await cloudinaryServices.uploadFile(_pickedVideo!);
    if(customThumbnail==null){
      String videoFileName = _pickedVideo!.path.split('/').last;
      String thumbnailFileName = videoFileName.replaceAll(RegExp(r'\.\w+$'), '.jpg');
     _thumbnailUrl= await cloudinaryServices.uploadUint8List(thumbnail!,thumbnailFileName);
    }
    else{
      _thumbnailUrl= await cloudinaryServices.uploadFile(customThumbnail!);
    }
    final meta = await getVideoMetaData(_pickedVideo!);

// ✅ Fetch location
//final locationTag = currentLocation ?? "Unknown Location";
final locationTag = await LocationHelper.getCurrentLocationTag() ?? "Unknown Location";
final placeName = detectedPlace; 
if (videoUrl != null && _thumbnailUrl != null) {
  VideoModel videoDetails = VideoModel(
    PrivacyType: visibility ? "public" : "private",
    videoCaption: captionController.text,
    ageRestricted: false,
    videoUrl: videoUrl,
    thumbnailUrl: _thumbnailUrl!,
    videoGenre: 'motivation',
    ShareLink: 'asdasdas',
    locationTag: locationTag, // ✅ Dynamic location tag
    place: placeName,
    duration: meta['duration'],
    originalAudioOwnerId: SessionController().id!,
    videoResolution: meta['resolution'],
    videoRatio: meta['ratio'],
    isOriginalSound: true,
    //taggedUsers: _taggedUsers.map((user) => user.id).toList(),
  );

  debugPrint("🎯 Video Location: $locationTag");
  log('[PostVideoViewModel] Preparing upload with placeName=$placeName, locationTag=$locationTag');
  await videoRepo.publishVideo(
    videoDetails: videoDetails,
    token: SessionController().token,
   
  );
}

    // final meta = await getVideoMetaData(_pickedVideo!);
    // if(videoUrl!=null && _thumbnailUrl!=null){
    //   VideoModel videoDetails=VideoModel(
    //       PrivacyType:visibility?"public":"private",
    //       videoCaption: captionController.text,
    //       ageRestricted: false,
    //       videoUrl: videoUrl,
    //       thumbnailUrl: _thumbnailUrl!,
    //       videoGenre: 'motivation',
    //       ShareLink: 'asdasdas',
    //       locationTag: "Lahore,Pakistan",
    //       duration: meta['duration'],
    //       originalAudioOwnerId: SessionController().id!,
    //       videoResolution: meta['resolution'],
    //       videoRatio: meta['ratio'],
    //       isOriginalSound: true);
    //   debugPrint(videoDetails.toString());
    //     await videoRepo.publishVideo(videoDetails: videoDetails, token: SessionController().token);

    // }
    }catch(e){
      log(e.toString());
    }finally{
      setLoading(false);
    }
}


}
