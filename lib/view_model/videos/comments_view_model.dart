import 'dart:developer';
import 'package:be_life_style/model/comment_response_model/comment_response_model.dart';
import 'package:be_life_style/repo/comments/comments_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:flutter/cupertino.dart';

class CommentsViewModel with ChangeNotifier{
  CommentsViewModel({required this.commentsRepo,required int id}){
fetchVideoComments(id);
}
final commentController=TextEditingController();
final CommentsRepo commentsRepo;
  bool _isLoading=false;
  bool get isLoading=>_isLoading;

 final List<CommentResponseModel> _commentList=[];
 List<CommentResponseModel> get commentList=>_commentList;

  void setLoading(bool val){
    _isLoading=val;
    notifyListeners();
  }

  Future<void> fetchVideoComments(int id)async{
   if(!_isLoading) setLoading(true);
try{
  commentList.clear();
 final comments= await commentsRepo.fetchComments(id: id, token: SessionController().token);
  _commentList.addAll(comments);
  notifyListeners();
}catch(e){
  log(e.toString());
}finally{
setLoading(false);
}
  }
  void updateLikeCount(int commentId) {
    int index = _commentList.indexWhere((comment) => comment.id == commentId);
    if (index != -1) {
      _commentList[index] = _commentList[index].copyWith(likesCount:_commentList[index].isLiked==false? _commentList[index].likesCount+1:_commentList[index].likesCount-1,isLiked: !_commentList[index].isLiked!);
      notifyListeners();
    }
    notifyListeners();
  }
  Future<void> toggleComment(int id)async{

    try{
      updateLikeCount(id);
      await commentsRepo.likeComment(id: id, token: SessionController().token);
    }catch(e){
      log(e.toString());
    }
  }

  Future<void> addComment({required int id})async{
    setLoading(true);
    try{
      await commentsRepo.addComment(id: id, token: SessionController().token, text: commentController.text);
      await fetchVideoComments(id);
    }catch(e){
       log(e.toString());
    }finally{
      setLoading(false);
    }
  }
}