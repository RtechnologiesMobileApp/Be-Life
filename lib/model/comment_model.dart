class CommentModel{
  final String name;
  final String comment;
  final bool isLiked;
  const CommentModel({required this.name,required this.comment,this.isLiked=false});
CommentModel copyWith({bool? isLiked}){
  return CommentModel(name: name, comment: comment,isLiked: isLiked??this.isLiked);
}
}
