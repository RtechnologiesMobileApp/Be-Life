
import 'package:another_flushbar/flushbar.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../config/routes/route_names.dart';
import '../../res/components/background.dart';
import '../../res/components/custom_app_bar.dart';
import '../../res/components/custom_btn.dart';
import '../../res/components/custom_linear_progress_bar.dart';
import '../../res/components/custom_text_field.dart';
import '../../utils/flushbar_helper.dart';
import '../../view_model/auth/signup_view_model.dart';

class EmailInputView extends StatelessWidget {
  const EmailInputView({super.key});

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
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + MediaQuery.of(context).padding.top),
            CustomLinearProgressBar(value: 0.25),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w,),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 24.h,),
                    Align(alignment:Alignment.topLeft, child:  Text("What’s your email?",style: Theme.of(context).textTheme.headlineMedium,)),
                    SizedBox(height: 32.h,),
                    CustomTextField(controller:sVM.emailController,hintText: 'Enter Email', prefixIcon: SvgPicture.asset(AppImages.emailIcon), validator: (val ) {return null; }, onChanged: (val ) {  },),
                      const Spacer(),
                    CustomButton(text: "Continue", onPressed: (){
                      sVM.validateForm();
                      if(sVM.emailError==null){
                        Navigator.pushNamed(context, RouteName.dobInputScreen);
                      }
                      else{
                        FLushBarHelper.flushBarErrorMessage(sVM.emailError!, context,FlushbarPosition.TOP);
                      }


                    },color: Colors.white.withValues(alpha: 0.84,),textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),),
                    SizedBox(height: 32.h),
                  ],),
              ),
            ),
          ],
        ),)),
    );
  }
}
