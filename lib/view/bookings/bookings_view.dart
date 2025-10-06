import 'package:be_life_style/config/theme/app_colors.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/bookings/widgets/booking_card.dart';
import 'package:be_life_style/view/bookings/widgets/booking_place_card.dart';
import 'package:be_life_style/view/bookings/widgets/booking_search_bar.dart';
import 'package:be_life_style/view/bookings/widgets/booking_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
         elevation: 0,
        backgroundColor: Color(0xFFF6F6F6).withValues(alpha: 0.82),
      title:   Align(alignment:Alignment.topLeft,child: Text("Bookings",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),)),

      ),
      body: Container(
        height: double.infinity,
       color: Color(0xFFF6F6F6).withValues(alpha: 0.82),
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: kToolbarHeight + MediaQuery.of(context).padding.top),
               SizedBox(height: 56.h,),
                SizedBox(height: 16.h,),
              BookingCard(),
                SizedBox(height: 16.h,),
            Row(
              children: [
             Text("Booking summary",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700,fontSize: 18.sp,color: Colors.black),),
             const Spacer(),
                Text("Create An Itinerary",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700,color: AppColors.black,fontSize: 12.sp),),
               SizedBox(width: 4.w,),
                Icon(Icons.add,color: AppColors.black,)
            ],),
                SizedBox(height: 12.h,),
              BookingTabBar(),
                SizedBox(height: 16.h,),

                BookingPlaceCard(title: "Dinner at Luxe Bistro", loc: "123 Nightlife Ave", date: "Feb 21, 2025 8:30 PM", img: AppImages.bp0),
                SizedBox(height: 12.h,),
                BookingPlaceCard(title: "Dinner at Luxe Bistro", loc: "123 Nightlife Ave", date: "Feb 21, 2025 8:30 PM", img: AppImages.bp1)

            ],),),
            Positioned(top: kToolbarHeight + MediaQuery.of(context).padding.top,right:0,left:0,child: BookingSearchBar()),
          ],
        ),
      ),
    );
  }
}
