import 'package:be_life_style/view/bookings/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_model/booking_view_model.dart';

class BookingStatusWidget extends StatelessWidget {
  const BookingStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text("Booking status",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF808080),fontSize: 14.sp,letterSpacing: -0.23),),
      Consumer<BookingViewModel>(
          builder: (context,bVM,child) {
            return Column(children: List.generate(bVM.statusList.length, (index)=>StatusWidget(text: bVM.statusList[index].text, isChecked:  bVM.statusList[index].isSelected, index: index,),));
          }
      ),
    ],);
  }
}
