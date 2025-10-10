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
        currentLocation = "${p.locality}, ${p.country}";
        // Prefer a human-friendly place: name > subLocality > street > locality
        placeName = p.name?.isNotEmpty == true
            ? p.name
            : (p.subLocality?.isNotEmpty == true
                ? p.subLocality
                : (p.street?.isNotEmpty == true ? p.street : p.locality));
        log("[PostVideoViewModel] Reverse geocoded currentLocation=$currentLocation placeName=$placeName");
        notifyListeners();
      }
    } catch (e) {
      print("❌ Location error: $e");
    }
  }
 
 
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
final locationTag = await LocationHelper.getCurrentLocationTag() ?? "Unknown Location";

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
