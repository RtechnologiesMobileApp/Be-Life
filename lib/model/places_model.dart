class PlacesModel{
  final String name;
  final String likes;
  final String comments;
  final String img;
  final bool isLiked;
  const PlacesModel({required this.name,required this.comments,required this.img,required this.isLiked,required this.likes});

  PlacesModel copyWith({bool? isLiked}){
    return PlacesModel(name: name, comments: comments, img: img, isLiked: isLiked??this.isLiked, likes: likes);
  }
}