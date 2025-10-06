
import 'package:be_life_style/config/theme/app_colors.dart';
import 'package:be_life_style/view/bookings/widgets/dd_widget.dart';
import 'package:be_life_style/view/bookings/widgets/search_booking_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../res/components/custom_btn.dart';
import '../../../view_model/booking_view_model.dart';
import 'booking_status_widget.dart';
import 'categories_widget.dart';


class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>BookingViewModel(),
      child: Container(
        width: double.infinity,
        padding:  EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 4.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment:Alignment.center,child: Container(height: 3.h,width: 33.w,color: Color(0xFFD1D4D7),)),
           SizedBox(height: 19,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width:55.w,child: InkWell(onTap: (){
                  Navigator.pop(context);
                },child: Icon(Icons.close,color: Colors.black,))),
                Spacer(),
                Text("Filter",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black,fontSize: 20.sp),),
                Spacer(),
                Builder(
                  builder: (context) {
                    return InkWell(onTap: (){
                      context.read<BookingViewModel>().clearAll();
                    },child: Text("Clear all",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,),));
                  }
                ),
                    ],),
            SizedBox(height: 23.h,),
            Text("Filter by location",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF808080),fontSize: 14.sp,letterSpacing: -0.23),),
            SizedBox(height: 16.h,),
            SearchBookingField(hintText: 'Search location',),
           SizedBox(height: 24.h,),
            BookingStatusWidget(),
            SizedBox(height: 24.h,),
            CategoriesWidget(),
            SizedBox(height: 24.h,),
            DdWidget(),
            const Spacer(),
            CustomButton(text: "Find results",color: AppColors.black, onPressed: (){}),
            SizedBox(height: 24.h,),

          ],),
      ),
    );
  }
}
