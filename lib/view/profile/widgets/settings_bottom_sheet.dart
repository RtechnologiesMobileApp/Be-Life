import 'package:be_life_style/config/theme/app_colors.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/routes/route_names.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(mainAxisSize: MainAxisSize.min,
        children: [
        SizedBox(height: 8.h,),
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        leading: SvgPicture.asset(AppImages.userStarIcon),
        title: Text("Creator dashboard",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:AppColors.black ),),
       trailing: Icon(Icons.arrow_forward_ios,size: 18.h,),
      ),
        SizedBox(height: 2.h,),
        ListTile(
          onTap: (){
            Navigator.pushNamed(context, RouteName.settingsScreen);
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          leading: SvgPicture.asset(AppImages.settingsIcon),
          title: Text("Settings",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:AppColors.black ),),
          trailing: Icon(Icons.arrow_forward_ios,size: 18.h,),
        ),
        SizedBox(height: 24.h,),

      ],),
    );
  }
}
