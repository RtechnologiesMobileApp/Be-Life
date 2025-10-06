import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodoTab extends StatelessWidget {
  const TodoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 21.h,),
      ListTile(
        minTileHeight: 0,
        contentPadding: EdgeInsets.zero,
        leading: Icon(CupertinoIcons.location_fill),
        title: Text("Current location",style: TextStyle(color: Colors.black,fontSize: 16.sp,fontWeight: FontWeight.w700,letterSpacing: -0.3),),
        trailing: Icon(CupertinoIcons.arrow_up_right,size: 20.h,),
      ),
      ListTile(
        minTileHeight: 0,
        contentPadding: EdgeInsets.zero,
        title: Text("Pilates Class",style: TextStyle(color: Color(0xFF696969),fontSize: 16.sp,fontWeight: FontWeight.w400,letterSpacing: -0.1),),
        trailing: Icon(CupertinoIcons.arrow_up_right,size: 20.h,),
      ),
      ListTile(
        minTileHeight: 0,
        contentPadding: EdgeInsets.zero,
        title: Text("Pilates Class Atlanta",style: TextStyle(color: Color(0xFF696969),fontSize: 16.sp,fontWeight: FontWeight.w400,letterSpacing: -0.1),),
        trailing: Icon(CupertinoIcons.arrow_up_right,size: 20.h,),
      ),
      ListTile(
        minTileHeight: 0,
        contentPadding: EdgeInsets.zero,
        title: Text("Pilates Class The Daily Pilates Buckhead",style: TextStyle(color: Color(0xFF696969),fontSize: 16.sp,fontWeight: FontWeight.w400,letterSpacing: -0.1),),
        trailing: Icon(CupertinoIcons.arrow_up_right,size: 20.h,),
      ),
    ],);
  }
}
