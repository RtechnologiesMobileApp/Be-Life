import 'dart:ui';
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
class BookingPlaceCard extends StatelessWidget {
  const BookingPlaceCard({super.key, required this.title, required this.loc, required this.date, required this.img});
  final String title;
  final String loc;
  final String date;
  final String img;
  @override
  Widget build(BuildContext context) {
    return    InkWell(
      onTap: (){
        Navigator.pushNamed(context, RouteName.bookingPlaceDetails);
      },
      child: SizedBox(height: 200.h,width:double.infinity,child: Stack(
        children: [
          Image.asset(img,fit: BoxFit.cover,height: 200.h,),
          Positioned(bottom: 10.h,left: 10.w,right: 10.w,
            child:Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30.4, sigmaY: 30.4),
                        child: Container(

                          constraints: BoxConstraints(
                            maxHeight: 24.h,
                            minWidth: 139.w,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.14),borderRadius: BorderRadius.circular(16)),
                          child: Center(child: Text(title,style: Theme.of(context).textTheme.bodyMedium)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h,),
                Row( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.date_range,color: Colors.white,size: 15.h,),
                    SizedBox(width: 4.w,),
                    Text(date,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,),),
                  ],
                ),
                SizedBox(height: 6.h,),

                Row(
                  children: [
                    Icon(Icons.location_on_outlined,color: Colors.white,size: 15.h,),
                    SizedBox(width: 4.w,),
                    Text(loc,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,),),
                  Expanded(child: SizedBox()),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30.4, sigmaY: 30.4),
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: 23.h,
                            minWidth: 68.w,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.14),borderRadius: BorderRadius.circular(16)),
                          child: Center(child: Text("Confirmed",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp))),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),),
        ],
      ),),
    );
  }
}
