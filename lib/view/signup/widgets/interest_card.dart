import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({super.key, required this.img, required this.title, required this.subTitle, required this.isSelected, required this.func});
 final String img;
 final String title;
 final String subTitle;
 final bool isSelected;
 final VoidCallback func;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        height: 177.h,
        width: 168.w,
        decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.90),
            borderRadius: BorderRadius.circular(16)
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w,vertical:16.h),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(img,height: 73.h,width: 73.w,),
                  Text(title,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF202020),fontSize: 18.sp)),
                  Text(subTitle,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xFF202020).withValues(alpha: 0.60),fontSize: 12.sp,letterSpacing: -0.5,height: 1.2),textAlign: TextAlign.center,)
                ],),
            ),
            Positioned(
              top: 16.h,
              right: 16.h,
              child: isSelected? Container(height: 20.h,width: 20.h,
                child: SvgPicture.asset(AppImages.checkIconBlack),
              ):
              Container(
                height: 20.h,width: 20.h,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.black.withValues(alpha: 0.5))
              ),),
            )
          ],
        ),
      ),
    );
  }
}
