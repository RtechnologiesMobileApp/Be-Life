import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PassInputField extends StatelessWidget {
  const PassInputField({super.key,required this.hintText,this.suffixIcon=const SizedBox(), required this.validator, required this.onChanged,this.obs=false,  this.controller});
  final String hintText;
  final Widget suffixIcon;
  final TextEditingController? controller;
  final bool obs;
  final void Function(String val)? onChanged;
  final  String? Function(String? val)? validator;
  @override
  Widget build(BuildContext context) {
    return     ClipRRect(
        child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40,sigmaY: 40),child: Container(height: 56.h,width: 346.w,decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.20),
      borderRadius: BorderRadius.circular(12),),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: TextFormField(
          style:  Theme.of(context).textTheme.bodyLarge,
          controller: controller,
          obscureText: obs,
          validator: validator,
          onChanged: onChanged,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyLarge,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),)));
  }
}
