import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key,});
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.hexagonDots(color: AppColors.black, size:40.h );

  }
}
