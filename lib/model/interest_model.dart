class InterestModel{
  final String img;
  final String title;
  final String subTitle;
  final bool isSelected;
  const InterestModel({required this.img,required this.title,required this.subTitle,required this.isSelected});

  InterestModel copyWith({bool? isSelected}){
    return InterestModel(img: img, title: title, subTitle: subTitle, isSelected: isSelected??this.isSelected);
  }
}