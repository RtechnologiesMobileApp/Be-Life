import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/app_colors.dart';
import '../../../utils/app_images.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.topLeft,
                child: Text("Reviews",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 18.sp,color: Colors.black),)),
            SizedBox(height: 11.h,),

            Row(
              children: [
                Image.asset(AppImages.profileImg,height: 36.h,width: 36.w,fit: BoxFit.cover,),
                SizedBox(width: 7.w,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sophia Carter",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black,fontSize: 14.sp),),
                    Row(
                      children: [
                        Row(children: List.generate(6, (_)=>Icon(Icons.star,color: Color(0xFFECB91E),size: 15.h,)),),
                        SizedBox(width: 5.w,),
                        Icon(Icons.circle,size: 4.h,color: Color(0xFF8E937B),),
                        SizedBox(width: 5.w,),
                        Image.asset(AppImages.googleMapsIcon,height: 12.h,width: 57,fit: BoxFit.cover,),
                        SizedBox(width: 5.w,),
                        Icon(Icons.circle,size: 4.h,color: Color(0xFF8E937B),),
                        SizedBox(width: 5.w,),
                        Text("1-12-2025",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.greenColor,fontSize: 8.sp),),
                      ],
                    ),
                  ],),

              ],),
            SizedBox(height: 3.h,),
            Text.rich(TextSpan(text:
            "I had an amazing stay at the Kimpton EPIC Miami! From the moment I arrived, the staff was incredibly welcoming and attentive. The hotel’s vibe is chic and modern, with sleek decor and breathtaking views of th...",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: Colors.black,letterSpacing: -0.3,height: 1),
                children: [TextSpan(text: "more",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Color(0xFF979797,),fontSize: 12.sp))]
            )

            ),

          ],
        ),
      ),
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 11.h,),

            Row(
              children: [
                Image.asset(AppImages.pp2,height: 36.h,width: 36.w,fit: BoxFit.cover,),
                SizedBox(width: 7.w,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jane Doe",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black,fontSize: 14.sp),),
                    Row(
                      children: [
                        Row(children: List.generate(6, (_)=>Icon(Icons.star,color: Color(0xFFECB91E),size: 15.h,)),),
                        SizedBox(width: 5.w,),
                        Icon(Icons.circle,size: 4.h,color: Color(0xFF8E937B),),
                        SizedBox(width: 5.w,),
                        Image.asset(AppImages.googleMapsIcon,height: 12.h,width: 57,fit: BoxFit.cover,),
                        SizedBox(width: 5.w,),
                        Icon(Icons.circle,size: 4.h,color: Color(0xFF8E937B),),
                        SizedBox(width: 5.w,),
                        Text("12-30-2024",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.greenColor,fontSize: 8.sp),),
                      ],
                    ),
                  ],),

              ],),
            SizedBox(height: 3.h,),
            Text.rich(TextSpan(text:
            "Definitely a spot worth visiting if you're in the area!",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: Colors.black,letterSpacing: -0.3,height: 1),
                children: [TextSpan(text: "",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Color(0xFF979797,),fontSize: 12.sp))]
            )

            ),
          ],
        ),
      ),
      SizedBox(height: 11.h,),

      Container(height: 30.h,
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xFFEAEBEB),borderRadius: BorderRadius.circular(4)),
        child: Center(child: Text("View All",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 18.sp,color: Colors.black,),textAlign: TextAlign.center,)),
      ),
    ],);
  }
}
