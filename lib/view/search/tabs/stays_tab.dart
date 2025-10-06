import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/search/tabs/widgets/rectangle_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StaysTab extends StatelessWidget {
  const StaysTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 21.h,),
      RectangleWidget(title: 'Miami, Florida', subTitle: 'Going to', icon: Icon(Icons.location_on_outlined,color: Colors.black54,),),
      SizedBox(height: 16.h,),
      RectangleWidget(title: 'June 2 - June 5', subTitle: 'Dates', icon: Icon(Icons.date_range,color: Colors.black54,),),
      SizedBox(height: 16.h,),
      RectangleWidget(title: '4 Travelers', subTitle: 'Travelers', icon: SvgPicture.asset(AppImages.travelersIcon,height: 19.h,width: 19.w,fit: BoxFit.cover,)),

    ],);
  }
}
