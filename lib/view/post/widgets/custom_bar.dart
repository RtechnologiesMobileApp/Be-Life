
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomBar extends StatelessWidget {
 final Widget leading;
  final String title;
  final Widget trailing;
  final Widget subTitle;
  const CustomBar({super.key, required this.leading, required this.title, required this.trailing, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         leading,
          SizedBox(width: 12.w,),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xFF202020),fontSize: 14.sp),),
             subTitle
            ],),
          const Spacer(),
         trailing      ],),
    );
  }
}
