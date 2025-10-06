import 'package:be_life_style/model/booking_status_model.dart';
import 'package:flutter/material.dart';

class BookingViewModel with ChangeNotifier{

  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;
 String? _selectedCategory;
 String? get selectedCategory=>_selectedCategory;
  int _selectedIndex = 0;
  int get selectedIndex=>_selectedIndex;
String _selectedDate=  "Last 7 days" ;
  String get selectedDate=>_selectedDate;
   List<BookingStatusModel> _status=[
    BookingStatusModel(text: "Confirmed", isSelected:true),
    BookingStatusModel(text: "Pending", isSelected:false),
    BookingStatusModel(text: "Completed", isSelected:false),
  ];
  List<BookingStatusModel> get statusList=> _status;
  final List<String> _categoryList=[
    "Dining",
    "Wellness",
    "Travel",
    "Events",
    "Adventure",
    "Art and culture",
    "Shopping",
  ];
  List<String> get categoryList=> _categoryList;
  final List<String> _dateList=[
    "Last 3 days",
    "Last 7 days",
    "Last 14 days",
    "Last 30 days",
  ];
 List<String> get dateList=> _dateList;
 void clearAll(){
   _selectedCategory=null;
   _selectedDate= "Last 7 days";
   _status= [
   BookingStatusModel(text: "Confirmed", isSelected:false),
   BookingStatusModel(text: "Pending", isSelected:false),
   BookingStatusModel(text: "Completed", isSelected:false),
   ];
   notifyListeners();
 }
 void selectDate(String val){
   _selectedDate=val;
   notifyListeners();

 }

 void changeStatus(int index){
   _status[index]=_status[index].copyWith(isSelected: !_status[index].isSelected);
 notifyListeners();
 }
  void selectCategory(String val){
    _selectedCategory=val;
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
}