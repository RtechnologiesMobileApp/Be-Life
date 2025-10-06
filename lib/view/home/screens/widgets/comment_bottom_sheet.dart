import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/config/theme/app_colors.dart';
import 'package:be_life_style/repo/comments/comments_repo.dart';
import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/view_model/videos/comments_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'comment_box.dart';
import 'comment_text_field.dart';

class CommentBottomSheet extends StatelessWidget {
  const CommentBottomSheet({super.key,required this.id});
 final int id;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>CommentsViewModel(commentsRepo: getIt<CommentsRepo>(),id: id),
      child: SizedBox(
        height:534.h,
        width: double.infinity,
        child: Column(children: [
       Padding(
         padding:  EdgeInsets.symmetric(horizontal: 10.0.w,vertical: 4.h),
         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
           Icon(Icons.close,color: Colors.white.withValues(alpha: 0.9),),
           Text("Comments",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 16),),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon:  Icon(Icons.close,color: Colors.black,))
         ],),
       ),
         Consumer<CommentsViewModel>(
           builder: (context,cVM,child) {
             return cVM.isLoading?Expanded(
               child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   CustomLoader(),
                 ],
               ),
             ):Expanded(
               child:cVM.commentList.isEmpty?Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                 Text("No comments yet",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.black),),
               ],): ListView.builder(itemCount: cVM.commentList.length,itemBuilder:(context,index) {
                 final comment=cVM.commentList[index];
                 return CommentBox(profilePicture: comment.profilePicture,name:  comment.username, isLiked:  comment.isLiked??true, comment: comment.text,likes: comment.likesCount, func: () async{
                await  cVM.toggleComment(comment.id);
                 },);
               }),
             );
           }
         ),
          CommentTextField(id: id),
        ],),
      ),
    );
  }
}


// import 'package:be_life_style/view_model/home_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'comment_box.dart';
// import 'comment_text_field.dart';
//
// class CommentBottomSheet extends StatelessWidget {
//   const CommentBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_)=>HomeViewModel(),
//       child: SizedBox(
//         height:534.h,
//         width: double.infinity,
//         child: Column(children: [
//
//           Padding(
//             padding:  EdgeInsets.symmetric(horizontal: 10.0.w,vertical: 4.h),
//             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Icon(Icons.close,color: Colors.white.withValues(alpha: 0.9),),
//                 Text("Comments",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 16),),
//                 IconButton(onPressed: (){
//                   Navigator.pop(context);
//                 }, icon:  Icon(Icons.close,color: Colors.black,))
//               ],),
//           ),
//           Consumer<HomeViewModel>(
//               builder: (context,homeVM,child) {
//                 return Expanded(
//                   child: ListView.builder(itemCount: homeVM.comments.length,itemBuilder:(context,index) {
//                     final comment=homeVM.comments[index];
//                     return CommentBox(name:  comment.name, isLiked:  comment.isLiked, comment: comment.comment, func: () {
//                       homeVM.toggleCommentLike(index);
//                     },);
//                   }),
//                 );
//               }
//           ),
//           CommentTextField(),
//         ],),
//       ),
//     );
//   }
// }
