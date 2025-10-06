import 'package:be_life_style/model/search_item_model.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/material.dart';

class SearchViewModel with ChangeNotifier{
 final List<SearchItemModel> _items=[
    SearchItemModel(name: "2nd Cup Coffee", img: AppImages.ex1, subTitle: "Local’s guide to the best coffee sports", usrPic: AppImages.msgP1),
    SearchItemModel(name: "Nice Tour Bali", img: AppImages.ex2, subTitle: "Enjoy your best moment in Bali to view green sights",usrPic: AppImages.msgP5),
    SearchItemModel(name: "Diamond Luxury", img: AppImages.ex3, subTitle: "Discover the ultimate escape at Diamond hotel",usrPic: AppImages.msgP4),
  ];
 List<SearchItemModel> get items=>_items;
  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;
  int _selectedIndex = 0;
  int get selectedIndex=>_selectedIndex;
  void changeTab(int index){
    _selectedIndex=index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }
}