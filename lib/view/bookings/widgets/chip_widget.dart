import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/theme/app_colors.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({super.key, required this.text, required this.index});

 final String text;
 final int index;
  @override
  Widget build(BuildContext context) {
    return   Container(height: 32.h,
      decoration: BoxDecoration(color: index==0? AppColors.black:Colors.white,borderRadius: BorderRadius.circular(100)),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(child: Text(text,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color:  index==0? Colors.white:AppColors.black),),),
    );
  }
}
