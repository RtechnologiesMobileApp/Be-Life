import 'package:be_life_style/view_model/auth/signup_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_images.dart';

class PassValidationWidget extends StatelessWidget {
  const PassValidationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupViewModel>(
      builder: (context,val,child) {
        return Column(children: [
         if(val.passLengthValid) Row(
            children: [
              SvgPicture.asset(AppImages.checkIcon,height: 12.h,width: 12.h,),
              SizedBox(width: 8.w,),
              Text("A minimum of 8 characters",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),),
            ],
          ),
          SizedBox(height: 3.h,),

          if(val.lowerUpperCaseValid) Row(
            children: [
              SvgPicture.asset(AppImages.checkIcon,height: 12.h,width: 12.h,),
              SizedBox(width: 8.w,),
              Text("Lower and upper case letters",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),),
            ],
          ),
          SizedBox(height: 3.h,),

          if(val.atLeast1Num)Row(
            children: [
              SvgPicture.asset(AppImages.checkIcon,height: 12.h,width: 12.h,),
              SizedBox(width: 8.w,),
              Text("At least 1 number",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),),
            ],
          ),
          SizedBox(height: 3.h,),

          if(val.atLeast1Symbol) Row(
            children: [
              SvgPicture.asset(AppImages.checkIcon,height: 12.h,width: 12.h,),
              SizedBox(width: 8.w,),
              Text("At least 1 symbol",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),),
            ],
          ),
        ],);
      }
    );
  }
}
