
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AddLinkBottomSheet extends StatelessWidget {
   AddLinkBottomSheet({super.key});
final List<String> linkImages=[
  AppImages.link1Icon,
  AppImages.link2Icon,
  AppImages.link2Icon,
  AppImages.link4Icon,
 ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height:307.h,
      width: double.infinity,
      padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 4.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.close,color: Colors.white.withValues(alpha: 0.9),),
            Text("Add Link",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 16),),
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon:  Icon(Icons.close,color: Colors.black,))
          ],),
        SizedBox(height: 8.h,),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(linkImages.length, (index)=>Padding(
          padding:  EdgeInsets.symmetric(vertical: 8.0.h),
          child: SvgPicture.asset(linkImages[index]),
        )),)

      ],),
    );
  }
}
