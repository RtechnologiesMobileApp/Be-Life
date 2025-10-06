import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SearchBookingField extends StatelessWidget {
  const SearchBookingField({super.key,required this.hintText, this.prefixIcon=const SizedBox(), this.enabled=true});
  final String hintText;
  final Widget prefixIcon;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return  Container(height: 52.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 16.w),
      child: Row(children: [
        Icon(CupertinoIcons.search,size: 20.h,color: Colors.black,),
        SizedBox(width: 6.w,),
        Expanded(
          child: TextField(

            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF696969)),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: "Search location",
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,letterSpacing:-0.16),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),

      ],),
    );
  }
}
