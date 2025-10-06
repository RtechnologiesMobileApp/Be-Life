import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/theme/app_colors.dart';
class CustomAccordion extends StatelessWidget {
  const CustomAccordion({super.key, required this.title, required this.subTitle,  this.controller});
 final String title;
 final String subTitle;
 final ExpansionTileController? controller;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFEDEFF0))
        ),
        child: ExpansionTile(
          controller: controller,
          title: Text(title,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.black,fontSize: 14.sp),),
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.0.w,vertical: 6.h),
              child:  Text(subTitle,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:Color(0xFF797979),fontSize: 14.sp),),    )

          ],
        ),
      ),
    );
  }
}
