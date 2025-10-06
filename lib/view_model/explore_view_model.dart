import 'package:be_life_style/model/places_model.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/widgets.dart';

class ExploreViewModel with ChangeNotifier{
  final List<PlacesModel> _places=[
    PlacesModel(name: "Ancient temples", comments: "7.9k", img: AppImages.image1, isLiked: true, likes: "211.5k"),
    PlacesModel(name: "Nusa Dua Beach", comments: "586", img: AppImages.image2, isLiked: false, likes: "9.5k"),
    PlacesModel(name: "Beautiful Places", comments: "1.5k", img: AppImages.image4, isLiked: false, likes: "13.9k"),
    PlacesModel(name: "Majestic mountains", comments: "11", img: AppImages.image3, isLiked: false, likes: "7.5k"),
    PlacesModel(name: "Ancient temples", comments: "7.9k", img: AppImages.image5, isLiked: false, likes: "211.5k"),
    PlacesModel(name: "Ancient temples", comments: "7.9k", img: AppImages.image6, isLiked: false, likes: "211.5k"),
  ];
  List<PlacesModel>get places=>_places;

  toggleFav(int index){
    _places[index]=_places[index].copyWith(isLiked: !_places[index].isLiked);
    notifyListeners();
  }
}