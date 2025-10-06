import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_colors.dart';
import '../../../view_model/booking_view_model.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Category",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF808080),fontSize: 14.sp,letterSpacing: -0.23),),
        SizedBox(height: 16.h,),
        Consumer<BookingViewModel>(
            builder: (context,bVM,child) {
              return Wrap(children:List.generate(bVM.categoryList.length, (index)=>Padding(
                padding:  EdgeInsets.symmetric(horizontal: 3.0.w),
                child: InkWell(
                  onTap: (){
                    bVM.selectCategory(bVM.categoryList[index]);
                  },
                  child: Chip(
                      backgroundColor: bVM.categoryList[index]==bVM.selectedCategory?AppColors.black:Colors.white,
                      label: Text(bVM.categoryList[index],style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: bVM.selectedCategory==bVM.categoryList[index]?Colors.white:AppColors.black),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                ),
              )
              ));
            }
        ),
      ],);
  }
}
