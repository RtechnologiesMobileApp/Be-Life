
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ShareBottomSheet extends StatelessWidget {
  const ShareBottomSheet({super.key});
Widget customWidget({required String img, required String text,required BuildContext context}){
  return  Column(
    children: [
      Image.asset(img,height: 52.h,width: 52.w,fit: BoxFit.cover,),
      SizedBox(height: 6.h,),
      Text(text,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),)
    ],);
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height:411.h,
      width: double.infinity,
      padding:  EdgeInsets.symmetric(horizontal: 10.0.w,vertical: 4.h),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.close,color: Colors.white.withValues(alpha: 0.9),),
            Text("Share",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 16),),
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon:  Icon(Icons.close,color: Colors.black,))
          ],),
        SizedBox(height: 8.h,),
       Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
         Flexible(child: customWidget(img: AppImages.comProfileIcon,text: "Anna",context: context)),
         Flexible(child: customWidget(img: AppImages.pp2,text: "Jane",context: context)),
         Flexible(child: customWidget(img: AppImages.pp3,text: "camée",context: context)),
         Flexible(child: customWidget(img: AppImages.pp4,text: "super",context: context)),
         Flexible(child: customWidget(img: AppImages.pp5,text: "Jane",context: context)),
       ],),
        SizedBox(height: 30.h,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(child: customWidget(img: AppImages.fbIcon,text: "Facebook",context: context)),
            Flexible(child: customWidget(img: AppImages.waIcon,text: "Whatsapp",context: context)),
            Flexible(child: customWidget(img: AppImages.msgGIcon,text: "SMS",context: context)),
            Flexible(child: customWidget(img: AppImages.insIcon,text: "Instagram",context: context)),
            Flexible(child: customWidget(img: AppImages.optionsIcon,text: "More",context: context)),
          ],),
        SizedBox(height: 30.h,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(child: customWidget(img: AppImages.linkIcon,text: "Copy link",context: context)),
            Flexible(child: customWidget(img: AppImages.flagIcon,text: "Report",context: context)),
            Flexible(child: customWidget(img: AppImages.AaIcon,text: "Captions",context: context)),
          SizedBox(height: 52.h,width: 52.w,),
          SizedBox(height: 52.h,width: 52.w,),
           ],),

      ],),
    );
  }
}
