import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/theme/app_colors.dart';
import '../../../utils/app_images.dart';
class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 64.h,width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading:     Container(height: 40.h,width:40.w,
              padding: EdgeInsets.all(8),
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(100),

                  gradient: LinearGradient(colors: [
                    Color(0xFF788365),
                    Color(0xFFA5A590),
                  ])
              ),child: SvgPicture.asset(AppImages.calendarIcon,color: Colors.white,height: 24.h,width: 24.w,fit: BoxFit.cover,)),
          title: Text("Booking summary",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700,color: Colors.black),),
          subtitle: Text("You have 3 upcoming bookings",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.greenColor),),
        ),
      ),
    );
  }
}
