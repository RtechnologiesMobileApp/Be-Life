import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
class PlaceCardWidget extends StatelessWidget {
  const PlaceCardWidget({super.key, required this.title, required this.pP, required this.subTitle, required this.img});
final String title;
final String pP;
final String subTitle;
final String img;
  @override
  Widget build(BuildContext context) {
    return    SizedBox(height: 200.h,width:double.infinity,child: Stack(
      children: [
        Image.asset(img,fit: BoxFit.cover,height: 200.h,),
        Positioned(bottom: 10.h,left: 10.w,right: 10.w,
          child:Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30.4, sigmaY: 30.4),
                      child: Container(
                        height: 24.h,
                        constraints: BoxConstraints(
                          minWidth: 139.w,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.22),borderRadius: BorderRadius.circular(16)),
                        child: Row( mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(pP,height: 16.h,width: 16.h,fit: BoxFit.cover,),
                            SizedBox(width: 6.w,),
                            Text(title,style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  Text(subTitle,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,),)
                ],
              ),
              Icon(CupertinoIcons.arrow_up_right,size: 19.h,color: Colors.white,),
            ],
          ),),
      ],
    ),);
  }
}
