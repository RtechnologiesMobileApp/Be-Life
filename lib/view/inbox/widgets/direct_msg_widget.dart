import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/app_images.dart';
class DirectMsgWidget extends StatelessWidget {
  const DirectMsgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SvgPicture.asset(AppImages.directMsg,fit: BoxFit.cover,height: 40.h,width: 40.h,),
      SizedBox(width: 8.w,),
      Text("Direct message",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: Colors.black),),
      SizedBox(width: 4.w,),
      Container(height: 20.h,width: 20.w,
        decoration: BoxDecoration(
            color: Color(0xFFFF534D),
            borderRadius: BorderRadius.circular(16)
        ),
        child: Center(child: Text("2",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10.sp),),),),
      const Spacer(),
      IconButton(onPressed: (){
        Navigator.pushNamed(context, RouteName.directMsgScreen);
      }, icon: Icon(Icons.arrow_forward_ios,color: Color(0xFFCCCCCC),size: 20.h,))
    ],);
  }
}
