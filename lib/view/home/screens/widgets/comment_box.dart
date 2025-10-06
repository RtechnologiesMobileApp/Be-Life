import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({super.key, required this.name, required this.isLiked, required this.comment, required this.func, required this.profilePicture, required this.likes});
 final String name;
 final bool isLiked;
 final String comment;
 final String profilePicture;
 final int likes;
 final VoidCallback func;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 9.0.w,vertical: 9.h),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(height:39.h,width:39.w,child: ClipRRect(borderRadius: BorderRadius.circular(1000.r),child: CachedNetworkImage(imageUrl: profilePicture,fit: BoxFit.cover,))),
        SizedBox(width: 5.w,),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: name,
                  style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w700,  letterSpacing: -0.48,color: Colors.black),
                  children: [
                    TextSpan(
                        text: '',
                        style:TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,  letterSpacing: -0.48,color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(height: 2.h,),
              Text( comment,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,letterSpacing: 0.56,color: Colors.black),textAlign: TextAlign.left,),
              SizedBox(height: 10.h,),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reply",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,letterSpacing: 0.56,color: Color(0xFF797979),fontWeight: FontWeight.w700),textAlign: TextAlign.left,),
                  Padding(
                    padding:  EdgeInsets.only(right: 19.0.w),
                    child: Row(
                      children: [
                        InkWell(onTap: func,child: Icon( isLiked?CupertinoIcons.heart_fill:CupertinoIcons.heart,color: isLiked?Colors.red:Color(0xFF797979),size: 22.h,)),
                        SizedBox(width: 5.w,),
                        Text("$likes",style: Theme.of(context).textTheme.bodyLarge!.copyWith(letterSpacing: 0.56,color: Color(0xFF696969),),textAlign: TextAlign.left,),
                      ],
                    ),
                  ),

                ],)
            ],),
        )
      ],),
    );
  }
}
