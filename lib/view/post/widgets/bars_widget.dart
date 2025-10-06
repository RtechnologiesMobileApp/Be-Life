import 'package:be_life_style/view/post/widgets/add_link_bottom_sheet.dart';
import 'package:be_life_style/view_model/videos/post_video_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_images.dart';
import 'custom_bar.dart';

class BarsWidget extends StatelessWidget {
  const BarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CustomBar(leading: SvgPicture.asset(AppImages.locIcon,height: 20.h,width: 20.h,fit: BoxFit.cover,color: Colors.black,),
        title: "Location",
        trailing:Icon(Icons.arrow_forward_ios,size:18.h,color: Color(0xFF696969),),
        subTitle: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFF6F6F6),
            ),
            height: 28.h,
            margin: EdgeInsets.only(top: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child:Row(mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.close,color: Color(0xFF696969),),
                Text("1567 Broadway, New York",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp,color: Color(0xFF696969)),)
              ],)),
      ),
      CustomBar(leading: Icon(Icons.remove_red_eye_outlined), title: "Visibility",
        trailing:   SizedBox(height:24.h,width:48.w,child: FittedBox(
            fit: BoxFit.contain,
            child: Selector<PostVideoViewModel,bool>(
              selector: (_,pVM)=>pVM.visibility,
              builder: (_,visibility,_) {
                return CupertinoSwitch(activeTrackColor: Color(0xFF202020) ,value: visibility, onChanged: (val){
                  context.read<PostVideoViewModel>().toggleVisibility();
                });
              }
            ))),
        subTitle: Text("Public or friends only videos",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp,color: Color(0xFF696969)),),
      ),
      CustomBar(leading: SvgPicture.asset(AppImages.addUser,height: 20.h,width: 20.h,fit: BoxFit.cover,color: Colors.black,),
        title: "Tag people",
        trailing: Icon(Icons.arrow_forward_ios,size:18.h,color: Color(0xFF696969),),
        subTitle: Row( crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFF6F6F6),
                ),
                height: 28.h,
                margin: EdgeInsets.only(top: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child:Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close,color: Color(0xFF696969),),
                    Text("Tiara",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp,color: Color(0xFF696969)),)
                  ],)),
            SizedBox(width: 8.w,),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFF6F6F6),
                ),
                height: 28.h,
                margin: EdgeInsets.only(top: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child:Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close,color: Color(0xFF696969),),
                    Text("Zack",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp,color: Color(0xFF696969)),)
                  ],)),
          ],
        ),
      ),
      CustomBar(leading: SvgPicture.asset(AppImages.linksIcon,height: 20.h,width: 20.h,fit: BoxFit.cover,color: Colors.black,),
        title: "Add Links",
        trailing:InkWell(onTap:(){
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              backgroundColor: Colors.white.withValues(alpha: 0.98),
              context: context, builder: (context)=>AddLinkBottomSheet());
        },child: Icon(Icons.arrow_forward_ios,size:18.h,color: Color(0xFF696969),)),
        subTitle: Container( height: 12.h,
        ),
      ),
      CustomBar(leading: SvgPicture.asset(AppImages.linksIcon,height: 20.h,width: 20.h,fit: BoxFit.cover,color: Colors.black,),
        title: "More options",
        trailing:Icon(Icons.more_horiz_rounded,size:18.h,color: Color(0xFF696969),),
        subTitle: Container( height: 14.h,
        ),),
    ],);
  }
}
