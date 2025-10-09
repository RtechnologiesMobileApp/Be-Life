import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:be_life_style/view_model/videos/comments_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final cVM = context.read<CommentsViewModel>();

    return Container(
      height: 42.h,
      margin: EdgeInsets.symmetric(vertical: 40.h, horizontal: 28.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1600),
        color: const Color(0xFFF6F6F6),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: cVM.commentController,
              onSubmitted: (val) {
                // cVM.addComment(id: id);
                cVM.addComment(
  id: id,
  profileVM: Provider.of<ProfileViewModel>(context, listen: false),
);
              },
              cursorColor: Colors.black,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: const Color(0xFF131313).withValues(alpha: 0.5),
              ),
              decoration: InputDecoration(
                hintText: "Add Comment...",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: const Color(0xFF131313).withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (cVM.commentController.text.trim().isNotEmpty) {
                // cVM.addComment(id: id);
                cVM.addComment(
  id: id,
  profileVM: Provider.of<ProfileViewModel>(context, listen: false),
);
                 cVM.commentController.clear();
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Icon(
                Icons.send,
                color: Colors.black.withValues(alpha: 0.6),
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 