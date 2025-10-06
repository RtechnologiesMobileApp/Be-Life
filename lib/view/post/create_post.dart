
import 'package:be_life_style/view/post/widgets/bars_widget.dart';
import 'package:be_life_style/view/post/widgets/cover_widget.dart';
import 'package:be_life_style/view/post/widgets/post_video_btn.dart';
import 'package:be_life_style/view_model/videos/post_video_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../res/components/custom_btn.dart';
class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
         title: Text("Post",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700,color: Colors.black),),
        actions: [
          ClipRRect(
            child: Container(width: 70.w,height: 32.h,
            decoration: BoxDecoration(
              color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(1000)),
            child: Center(child: Text("Preview",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: Color(0xFF0E0F10)),),),),
          ),
          SizedBox(width: 16.w,)
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: TextField(
                    maxLines: 5,
                    controller: context.read<PostVideoViewModel>().captionController,
                    cursorColor: Colors.black,
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xFF131313).withValues(alpha: 0.5)),
                    decoration: InputDecoration(
                      hintText: "Write a caption...",
                      hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xFF131313).withValues(alpha: 0.24)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),),
                  SizedBox(width: 12.w,),
                  Flexible(child: CoverWidget()),
                  // Image.asset(AppImages.editCover,height: 186.h,width: 127.w,fit: BoxFit.cover,)
                ],),
              SizedBox(height: 32.h,),
              BarsWidget(),

              SafeArea(
                child: Row(
                  children: [
                    Flexible(child: CustomButton(text: "Save draft", onPressed: (){},height: 56.h,width: 162.w,color: Color(0xFFF6F6F6),textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),)),
                    SizedBox(width: 12.w,),
                    Flexible(child: PostVideoBtn()),
                  ],
                ),
              ),
            ],),
        ),
      ),
    );
  }
}
