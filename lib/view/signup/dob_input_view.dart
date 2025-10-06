
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../config/routes/route_names.dart';
import '../../res/components/background.dart';
import '../../res/components/custom_app_bar.dart';
import '../../res/components/custom_btn.dart';
import '../../res/components/custom_linear_progress_bar.dart';
import '../../view_model/auth/signup_view_model.dart';

class DobInputView extends StatelessWidget {
  const DobInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final sVM = context.read<SignupViewModel>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
      ),
      body: Background(child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: kToolbarHeight + MediaQuery.of(context).padding.top),
            CustomLinearProgressBar(value: 0.375),
            SizedBox(height: 24.h,),
            Align(alignment:Alignment.topLeft,child: Text("What’s your date of birth?",style: Theme.of(context).textTheme.headlineMedium,)),
            SizedBox(height: 32.h,),
            SizedBox(
              height: 206.h,
              width: 343.w,
              child: Stack(
                children: [
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      primaryColor: Colors.grey, // Active overlay color
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white, // White text color
                        ),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      dateOrder: DatePickerDateOrder.dmy, // Day-Month-Year order
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (val) {
                        sVM.setDob(val);
                      },
                    ),
                  ),
                  // Overlay for active selection background color
                  IgnorePointer(
                    child: Center(
                      child: Container(
                        height: 36.h, // Height of the selected row
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.13), // Grey overlay color
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
            CustomButton(text: "Continue", onPressed: (){
              Navigator.pushNamed(context, RouteName.noInputScreen);

            },color: Colors.white.withValues(alpha: 0.84,),textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,),),
            SizedBox(height: 32.h),
          ],),)),
    );
  }
}
