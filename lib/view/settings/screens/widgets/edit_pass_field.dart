import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EditPassField extends StatelessWidget {
   EditPassField({super.key });

  final TextEditingController controller=TextEditingController(text: "123456789");

  @override
  Widget build(BuildContext context) {
    return   ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40,sigmaY: 40),
        child: Container(height: 56.h,width: 346.w,decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.13),
          borderRadius: BorderRadius.circular(12),),
          padding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 16.w),
          child: Center(
            child: TextFormField(
              controller: controller,
              obscureText: true,
             style:  Theme.of(context).textTheme.bodyLarge,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 17.h,),
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),),
      ),
    );
  }
}
