
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/routes/route_names.dart';
import '../../res/components/custom_btn.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const Spacer(flex: 2,),
              Align(alignment:Alignment.topLeft,child: SvgPicture.asset(AppImages.successIcon,height: 60.h,width: 60.w,)),
              SizedBox(height: 26.h,),
              Align(alignment:Alignment.topLeft,child: Text("Your account was created successfully",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Color(0xFF0E0F10),letterSpacing: -0.4,height: 1.3,fontWeight: FontWeight.w700),)),
              const Spacer(flex: 1,),
              CustomButton(text: "Go home", onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, RouteName.mainNavScreen,(route)=>false);
              },color: Color(0xFF202020)),
              SizedBox(height: 10.h),
              CustomButton(text: "See profile", onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, RouteName.mainNavScreen,(route)=>false);
              },color: Color(0xFFF6F6F6),textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),),
              SizedBox(height: 32.h),
            ],),
        ),),
    );
  }
}
