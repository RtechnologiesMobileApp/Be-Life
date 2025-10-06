
import 'package:another_flushbar/flushbar.dart';
import 'package:be_life_style/view/signup/widgets/no_input_field.dart';
import 'package:flutter/cupertino.dart';
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

class NoInputView extends StatelessWidget {
  const NoInputView({super.key});

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
            CustomLinearProgressBar(value: 0.5),
            SizedBox(height: 24.h,),
            Align(alignment:Alignment.topLeft,child: Text("Enter your number",style: Theme.of(context).textTheme.headlineMedium,)),
            SizedBox(height: 32.h,),
            NoInputField(),
            SizedBox(height: 24.h,),
            Align(
              alignment: Alignment.topLeft,
              child: Text.rich(
                TextSpan(
                  text: 'By entering, you agree to our ',
                  style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white.withValues(alpha: 0.84),height: 1.4),
                  children: [
                    TextSpan(
                      text: 'Privacy policy and terms of conditions',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600,height: 1.4),  ),
                  ],
                ),
              ),
            ),

            const Spacer(),
            CustomButton(text: "Continue", onPressed: (){
              sVM.validateForm();
              if(sVM.phoneNoError==null){
              context.read<SignupViewModel>().startTimer();
              Navigator.pushNamed(context, RouteName.codeInputScreen);}
              else{
                FLushBarHelper.flushBarErrorMessage(sVM.phoneNoError!, context,FlushbarPosition.TOP);

              }

            },color: Colors.white.withValues(alpha: 0.84,),textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,),),
            SizedBox(height: 32.h),
          ],),)),
    );
  }
}
