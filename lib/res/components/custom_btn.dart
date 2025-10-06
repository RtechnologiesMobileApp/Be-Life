import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/app_colors.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? textStyle;
  final double width;
  final double height;
  final Widget prefixIcon;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textStyle,
    this.width = 342,
    this.height = 56,
    this.prefixIcon=const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.lightBlue,
          borderRadius: BorderRadius.circular(1000),
        ),
        alignment: Alignment.center,
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:  EdgeInsets.only(left: 16.0.w),
              child: SizedBox(height:20.h,width:20.h,child: prefixIcon),
            ),
            Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.bodyLarge!.copyWith(letterSpacing: -0.5),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 16.0.w),
              child: SizedBox(height:20.h,width:20.h,),
            ),

          ],
        ),
      ),
    );
  }
}
