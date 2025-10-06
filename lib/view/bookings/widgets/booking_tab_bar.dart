import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chip_widget.dart';

class BookingTabBar extends StatelessWidget {
  const BookingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        ChipWidget(text: "Upcoming", index: 0,),
        SizedBox(width: 4.w,),
        ChipWidget(text: "Past", index: 1,),
        SizedBox(width: 4.w,),
        ChipWidget(text: "Cancelled", index: 2,),

      ],
    );
  }
}
