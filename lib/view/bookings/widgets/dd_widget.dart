import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_colors.dart';
import '../../../view_model/booking_view_model.dart';

class DdWidget extends StatelessWidget {
  const DdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF808080),fontSize: 14.sp,letterSpacing: -0.23),),
       SizedBox(height: 16.h,),
        Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Consumer<BookingViewModel>(
            builder: (context, bVM, child) {
              return DropdownButton<String>(
                dropdownColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.black,
                  letterSpacing: -1,
                ),
                isExpanded: true,
                value:  bVM.dateList.contains(bVM.selectedDate)
                    ? bVM.selectedDate
                    : null, // Ensure value exists in items
                hint: Text(
                  "Select Date",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.black,
                    letterSpacing: -1,
                  ),
                ),
                underline: SizedBox(), // Remove default underline
                items: bVM.dateList.map<DropdownMenuItem<String>>((String date) {
                  return DropdownMenuItem<String>(

                    value: date, // Each item should have its own value
                    child: Text(
                      date,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.black,
                        letterSpacing: -1,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    bVM.selectDate(val); // Update the selected date in ViewModel
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
