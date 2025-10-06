import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.suffixIcon = const SizedBox(),
    this.prefixIcon = const SizedBox(),
    required this.validator,
    required this.onChanged,
    this.obs = false,
    this.enabled = true,
    this.controller,
  });

  final String hintText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final bool obs;
  final bool? enabled;
  final TextEditingController? controller;
  final void Function(String val)? onChanged;
  final String? Function(String? val)? validator;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          height: 56.h,
          width: 346.w,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.13),
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w,),
          child: Row(
            children: [
              SizedBox(
              height: 20.h,width: 20.w,
                  child: prefixIcon),
              SizedBox(width: 10.w),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  enabled: enabled,
                  obscureText: obs,
                  validator: validator,
                  onChanged: onChanged,
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              SizedBox(
              height: 20.h,width: 20.w,child: suffixIcon),
            ],
          ),
        ),
      ),
    );
  }
}
