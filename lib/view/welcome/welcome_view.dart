
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/components/custom_app_bar.dart';
import '../../res/components/custom_btn.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppImages.welcomeBg,fit: BoxFit.cover)),
        Positioned.fill(child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 54.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 14.0.w),
                child: Text("Discover, Book, and Experience.",style: Theme.of(context).textTheme.headlineLarge,textAlign: TextAlign.center,),
              ),
              const Spacer(flex: 1,),
           CustomButton(text: "Sign in", onPressed: (){
             Navigator.pushNamed(context, RouteName.loginScreen);
           }),
           SizedBox(height: 15.h,),
           CustomButton(text: "Sign up", onPressed: (){
             Navigator.pushNamed(context, RouteName.nameInputScreen);

           },color: Colors.white.withValues(alpha: 0.84),textStyle:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black)),

            ],),
        ))
        ],
      )
    );
  }
}
