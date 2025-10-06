
import 'package:another_flushbar/flushbar.dart';
import 'package:be_life_style/view/signup/widgets/interest_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../config/routes/route_names.dart';
import '../../res/components/background.dart';
import '../../res/components/custom_app_bar.dart';
import '../../res/components/custom_btn.dart';
import '../../res/components/custom_linear_progress_bar.dart';
import '../../utils/flushbar_helper.dart';
import '../../view_model/auth/signup_view_model.dart';

class InterestsPickerView extends StatelessWidget {
  const InterestsPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    final sVM = context.read<SignupViewModel>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
      ),
      body: Background(child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + MediaQuery.of(context).padding.top),
            CustomLinearProgressBar(value: 0.875),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 24.h,),
                      Align(alignment:Alignment.topLeft,child: Text("Choose your interests",style: Theme.of(context).textTheme.headlineMedium,)),
                      SizedBox(height: 12.h,),
                      Align(alignment:Alignment.topLeft,child: Text("Interests are used to personalize your feed and will be visible on your profile.",style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.4.h,letterSpacing: -0.5),)),
                      SizedBox(height: 28.h,),
                      InterestGridView(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Color(0xFF5D8AC0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 28.h,),

                  CustomButton(text: "Done", onPressed: (){
                    if(sVM.selectedInterest.isEmpty){
                      FLushBarHelper.flushBarErrorMessage("Kindly select at least one interest", context,FlushbarPosition.TOP);
                    }
                    else{
                    Navigator.pushNamed(context, RouteName.completeProfileScreen);}

                  },color: Colors.white.withValues(alpha: 0.84,),textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),),
                  SizedBox(height: 32.h),
                ],),),
          ],
        ),)),
    );
  }
}
