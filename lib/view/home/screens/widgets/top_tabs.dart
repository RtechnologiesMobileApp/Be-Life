import 'package:be_life_style/view_model/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TopTab extends StatelessWidget {
  const TopTab({super.key, required this.text, required this.index});
final String text;
final int index;
  @override
  Widget build(BuildContext context) {
    return   Consumer<HomeViewModel>(
      builder: (context,hVm,child) {
        return GestureDetector(
          onTap: () {
            hVm.changeTab(index);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: hVm.selectedIndex==0?Colors.black:hVm.selectedIndex==index ? Colors.white : Colors.white70,
                    fontWeight: hVm.selectedIndex==index  ? FontWeight.w700 : FontWeight.w400,
                    fontSize:  hVm.selectedIndex==index ?18.sp:16.sp,
                  ),
                ),

                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  margin: EdgeInsets.only(top: 5.h),
                  height: 2.h,
                  width: hVm.selectedIndex==index  ? 29.w : 0,
                  color:  hVm.selectedIndex==0?Colors.black:Colors.white,
                ),
              ],
            ),
          ),
        );
      }
    );;
  }
}
