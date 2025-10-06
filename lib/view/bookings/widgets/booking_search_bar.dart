import 'package:be_life_style/view/bookings/widgets/filter_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BookingSearchBar extends StatelessWidget {
  const BookingSearchBar({super.key,this.isEnabled=true});
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return  Container(height: 52.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 16.w),
      child: Row(children: [
        Icon(CupertinoIcons.search,size: 20.h,),
        SizedBox(width: 10.w,),
        Expanded(
          child: TextField(
            enabled: isEnabled,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF696969)),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: isEnabled?"Search":"",
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF696969)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        SizedBox(width: 6.w,),
        InkWell(onTap: (){
          showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              backgroundColor: Colors.white.withValues(alpha: 0.98),
              context: context, builder: (context)=>FilterBottomSheet());

        },child: Icon(Icons.filter_list_sharp,size: 20.h,color: Color(0xFF696969),)),
      ],),
    );

  }
}
