import 'package:be_life_style/view/search/tabs/widgets/rectangle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_images.dart';

class FlightsTab extends StatelessWidget {
  const FlightsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 21.h,),
      RectangleWidget(title: 'Flying From', icon: Icon(Icons.location_on_outlined,color: Colors.black54,),),
     SizedBox(height: 16.h,),
      RectangleWidget(title: 'Flying To', icon: Icon(Icons.location_on_outlined,color: Colors.black54,),),
      SizedBox(height: 16.h,),
      RectangleWidget(title: 'Select Dates', icon: Icon(Icons.date_range,color: Colors.black54,), ),
      SizedBox(height: 16.h,),
      RectangleWidget(title: '1 Traveler', subTitle: 'Travelers', icon: SvgPicture.asset(AppImages.travelersIcon,height: 19.h,width: 19.w,fit: BoxFit.cover,)),
      SizedBox(height: 16.h,),
      RectangleWidget(title: 'Economy', subTitle: 'Preferred Seats', icon: Icon(Icons.airline_seat_recline_extra_sharp,color: Colors.black54,),),

    ],);
  }
}
