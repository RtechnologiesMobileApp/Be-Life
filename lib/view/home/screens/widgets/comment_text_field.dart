import 'package:be_life_style/view_model/home/home_view_model.dart';
import 'package:be_life_style/view_model/videos/comments_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({super.key, required this.id,});
 final int id;

  @override
  Widget build(BuildContext context) {
    final cVM=context.read<CommentsViewModel>();
    return Container(
      height: 42.h,
      margin: EdgeInsets.symmetric(vertical: 40.h,horizontal: 28.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1600),
          color: Color(0xFFF6F6F6)
      ),child: Center(child: TextField(
    controller: cVM.commentController,
      onSubmitted: (val){
      cVM.addComment(id: id,);
     //   homeVM.addComment(val);
      },
      cursorColor: Colors.black,
      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Color(0xFF131313).withValues(alpha: 0.5)),

      decoration: InputDecoration(

        hintText: "Add Comment...",
        hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Color(0xFF131313).withValues(alpha: 0.5)),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),

      ),
    ),),
    );
  }
}
