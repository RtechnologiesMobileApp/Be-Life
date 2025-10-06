import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/theme/app_colors.dart';
import '../../../utils/app_images.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 12.h),
      child: Column(children: [
        Row(children: [
          Container(height: 56.h,width: 56.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                image: DecorationImage(image: AssetImage(AppImages.placeIMG,),fit: BoxFit.cover)
            ),
          ),
          SizedBox(width: 12.w,),
          Flexible(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Kimpton EPIC",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 18.sp,color: Colors.black),),
                    SizedBox(width: 8.w,),
                    Container(height: 24.h,width: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(colors: [
                          Color(0xFF788365),
                          Color(0xFFA5A590),
                        ]),
                      ),
                      child: Center(child: Text("Travel",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,letterSpacing: -0.5),),),)
                  ],
                ),
                SizedBox(height: 2.h,),
                Text("270 Biscayne Blvd Way, Miami, FL 33131",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10.sp,color: AppColors.greenColor,letterSpacing: -0.2,height: 15/10),),
                Row( spacing: 2.w,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.star,color: Color(0xFFECB91E),size: 14.h,),
                    Text( " 5.0",style: TextStyle(color: Color(0xFF696969),fontSize: 12.sp,fontWeight: FontWeight.w700,letterSpacing: -0.2,height: 15/12),),
                    Text( " (16 reviews)",style: TextStyle(color: Color(0xFF696969),fontSize: 12.sp,fontWeight: FontWeight.w400,letterSpacing: -0.2,height: 15/12),),
                    Icon(Icons.circle,size: 4.h,color: Color(0xFF8E937B),),
                    Text( " Open",style: TextStyle(color: Color(0xFF696969),fontSize: 12.sp,fontWeight: FontWeight.w700,letterSpacing: -0.2,height: 15/12),),
                  ],
                ),
              ],),
          ),
          SvgPicture.asset(AppImages.callRoundImg,width: 46.w,height: 46.h,fit: BoxFit.cover,),
          SizedBox(width: 6.w,),
          SvgPicture.asset(AppImages.sendRoundImg,width: 46.w,height: 46.h,fit: BoxFit.cover,)
        ],),

      ],),
    );
  }
}
