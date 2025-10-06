class BookingStatusModel{
 final String text;
 final bool isSelected;
 BookingStatusModel({required this.text,required this.isSelected});
 BookingStatusModel copyWith({bool? isSelected}){
   return BookingStatusModel(text: text, isSelected: isSelected??this.isSelected);
 }
}