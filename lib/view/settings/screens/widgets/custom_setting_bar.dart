
import 'package:be_life_style/config/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CustomSettingBar extends StatelessWidget {
  final String leading;
  final String title;
  final String subTitle;

  final Widget trailing;
  const CustomSettingBar({super.key, required this.leading, required this.title, required this.subTitle, required this.trailing, });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(leading,height: 20.h,width: 20.h,fit: BoxFit.cover,color: AppColors.black,),
          SizedBox(width: 12.w,),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xFF202020),fontSize: 14.sp),),
              SizedBox(width:251.w,child: Text(subTitle,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xFF696969),fontSize: 12.sp),)),

            ],),
          const Spacer(),
         trailing,
               ],),
    );
  }
}
