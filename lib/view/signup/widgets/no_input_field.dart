import 'dart:ui';

import 'package:be_life_style/config/theme/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_model/auth/signup_view_model.dart';
class NoInputField extends StatelessWidget {
  const NoInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final sVM = context.read<SignupViewModel>();

    return ClipRRect(

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40,sigmaY: 40),
        child: Container(
          height: 56.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
            CountryCodePicker(
              searchStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.black),
              dialogBackgroundColor: Colors.white,
              dialogTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.black),
              flagWidth: 35.w,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              flagDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),

              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: 'US', // Set default country to United States
              favorite: ['US'],
              // optional. Shows only country name and flag
              showCountryOnly: true,
              // optional. Shows only country name and flag when popup is closed.
              showOnlyCountryWhenClosed: true,
              hideMainText: true,
              // optional. aligns the flag and the Text left
              alignLeft: false,
            ),

            Expanded(
              child: TextField(
                controller: sVM.phoneNoController,
                style: Theme.of(context).textTheme.bodyLarge,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText:"112 155 268 829",
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),

             ],),
        ),
      ),
    );
  }
}
