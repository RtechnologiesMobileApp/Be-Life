import 'package:be_life_style/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key, required this.icon, required this.text, required this.index});
final String icon;
final String text;
final int index;
  @override
  Widget build(BuildContext context) {
    return  Consumer<SearchViewModel>(
      builder: (context,sVM,child) {
        return InkWell(
          onTap: (){
            sVM.changeTab(index);
          },
          child: Container(
            height: 104.9.h,
            width: 110.w,
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            decoration: BoxDecoration(
                color: sVM.selectedIndex==index?Color(0xFF8E937B):Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(icon,height: 24.h,width: 24.w,fit: BoxFit.cover,color:sVM.selectedIndex==index?Colors.white: Color(0xFF696969),),
                Text(text,style: Theme.of(context).textTheme.bodyLarge!.copyWith(letterSpacing: -1,color:sVM.selectedIndex==index?Colors.white: Color(0xFF0A2340)),)
              ],),
          ),
        );
      }
    );
  }
}
