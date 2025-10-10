import 'package:another_flushbar/flushbar.dart';
// import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/utils/flushbar_helper.dart';
import 'package:be_life_style/view_model/auth/signup_view_model.dart';
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

class NameInputView extends StatelessWidget {
   const NameInputView({super.key});
  @override
  Widget build(BuildContext context) {
    final sVM = context.read<SignupViewModel>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Background(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: kToolbarHeight + MediaQuery.of(context).padding.top,
              ),
              CustomLinearProgressBar(value: 0.125),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "What’s your first name last name?",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: 32.h),
              CustomTextField(
                controller: sVM.firstNameController,
                hintText: 'First name',
                prefixIcon: SvgPicture.asset(AppImages.userIcon),
                validator: (val) {
                  return null;
                },
                onChanged: (val) {},
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: sVM.lastNameController,
                hintText: 'Last name',
                prefixIcon: SvgPicture.asset(AppImages.userIcon),
                validator: (val) {
                  return null;
                },
                onChanged: (val) {},
              ),
              const Spacer(),

          CustomButton(
            text: "Continue",

            onPressed: () {
              sVM.validateForm();
              if(sVM.firstNameError==null&&sVM.lastNameError==null){
                Navigator.pushNamed(context, RouteName.dobInputScreen);
              }
              else if(sVM.firstNameError!=null){
                FLushBarHelper.flushBarErrorMessage(sVM.firstNameError!, context,FlushbarPosition.TOP);
              }
              else if(sVM.lastNameError!=null){
                FLushBarHelper.flushBarErrorMessage(sVM.lastNameError!, context,FlushbarPosition.TOP);
              }
            },
            color: Colors.white.withValues(alpha: 0.84),
            textStyle: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.black),
          ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
