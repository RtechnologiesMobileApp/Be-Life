import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/components/custom_btn.dart';

class BottomBtn extends StatelessWidget {
  const BottomBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25,sigmaY: 25),
        child: Container(
          height: 105.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.82)
          ),child: Center(child: CustomButton(text: "Book now", onPressed: (){},color: Color(0xFF8E937B),),),
        ),
      ),
    );
  }
}
