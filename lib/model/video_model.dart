class VideoModelMock{
  final String url;
  final bool isBookmarked;
  final bool isLiked;
  final List<String> comments;
  const VideoModelMock({required this.url,required this.isBookmarked,required this.isLiked,required this.comments});

  VideoModelMock copyWith({bool? isLiked,bool? isBookmarked,}){
    return VideoModelMock(url: url, isBookmarked: isBookmarked??this.isBookmarked, isLiked: isLiked??this.isLiked, comments: comments);
  }
}