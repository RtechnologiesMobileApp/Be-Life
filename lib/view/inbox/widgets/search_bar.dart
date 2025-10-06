import 'package:be_life_style/view_model/chat/chat_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(height: 52.h,decoration: BoxDecoration(
      color: Color(0xFFF6F6F6),
      borderRadius: BorderRadius.circular(100),
    ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(child: TextField(
        cursorColor: Colors.black,
        onChanged: (val){
          context.read<ChatViewModel>().searchChat(val);
        },
        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xFF131313).withValues(alpha: 0.5)),
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.search,size: 20.h,),
          hintText: "Search user",
          hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xFF131313).withValues(alpha: 0.5)),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),

        ),
      ),),
    );
  }
}
