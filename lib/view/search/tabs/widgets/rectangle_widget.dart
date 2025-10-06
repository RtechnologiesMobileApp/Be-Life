import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';

class RectangleWidget extends StatelessWidget {
  const RectangleWidget({super.key, required this.title,  this.subTitle, required this.icon});
 final String title;
 final String? subTitle;
 final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minHeight: 39.h,
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child:Row(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           icon,
            SizedBox(width: 5.w,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               if(subTitle!=null) Text(subTitle!,style: TextStyle(color: AppColors.greenColor,fontSize: 12.sp,fontWeight: FontWeight.w400,height: 20/12.sp,letterSpacing: -0.1),),
                Text(title,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,height: 20/16.sp,letterSpacing: -0.1)),
              ],)

          ],)
    );
  }
}
