import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../model/video_model/video_model.dart';
import '../../../../utils/app_images.dart';

class LeftBar extends StatelessWidget {
  const LeftBar({super.key, required this.videoData});
  final VideoModel videoData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 14.0.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 28.h,
            constraints: BoxConstraints(
              minWidth: 104.w,
            ),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05),borderRadius: BorderRadius.circular(100)),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.locIcon,height: 12.h,width: 12.h,),
                    SizedBox(width: 2.w,),
                    Text(videoData.locationTag,style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 13.h,),
          SizedBox(width:240.w,child: Text(videoData.uploaderName??'',style: Theme.of(context).textTheme.bodyMedium!.copyWith(letterSpacing: -0.2,fontSize: 14.sp,fontWeight: FontWeight.w700))),
          SizedBox(height: 6.h,),
          SizedBox(width:240.w,child: Text(videoData.videoCaption??'',style: Theme.of(context).textTheme.bodyMedium!.copyWith(letterSpacing: -0.1,height: 1.12.h))),
          SizedBox(height:videoData.videoCaption==null?0.h: 6.h,),

          Row(
            children: [
              SvgPicture.asset(AppImages.locIcon,height: 12.h,width: 12.h,),
              SizedBox(width: 2.w,),
              Text(videoData.locationTag,style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          SizedBox(height: 6.h,),

          Container(
              height: 21.h,
              width: 102.w,
              decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(100)
              ),
              child: ClipRRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 25,sigmaX: 25),
                    child: Center(child: Text("Creator earns commission",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 8.sp),))),
              )),
          SizedBox(height: 16.h,),

        ],
      ),
    );
  }
}
