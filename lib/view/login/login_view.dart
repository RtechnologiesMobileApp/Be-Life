import 'package:another_flushbar/flushbar.dart';
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/services/auth/auth_services.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/utils/image_picker_utils.dart';
import 'package:be_life_style/view_model/auth/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../config/locator.dart';
import '../../res/components/background.dart';
import '../../res/components/custom_app_bar.dart';
import '../../res/components/custom_btn.dart';
import '../../res/components/custom_text_field.dart';
import '../../utils/flushbar_helper.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>LoginViewModel(authServices: getIt<AuthServices>(), imagePickerUtils: getIt<ImagePickerUtils>()),

      child: Builder(
        builder: (context) {
          final lVM=context.read<LoginViewModel>();
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CustomAppBar(
            ),
            body:  Background(child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w,),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: kToolbarHeight + MediaQuery.of(context).padding.top),
                    Text("Welcome Back!",style: Theme.of(context).textTheme.headlineLarge,),
                    SizedBox(height: 12.h,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 51.w),
                      child: Text("Enter your email and password to sign in your Be account.",style: Theme.of(context).textTheme.bodyLarge!.copyWith(letterSpacing: -0.5,height: 1.25),textAlign: TextAlign.center,),
                    ),
                    SizedBox(height: 32.h,),
                    CustomTextField(controller: context.read<LoginViewModel>().emailController,hintText: 'Enter Email', prefixIcon: SvgPicture.asset(AppImages.emailIcon), validator: (val ) {return null; }, onChanged: (val ) {  },),
                    SizedBox(height: 8.h,),
            Selector<LoginViewModel,bool>(
                selector: (_,lVM)=>lVM.obs,
                builder: (_,obs,_) {
                  return     CustomTextField(controller:context.read<LoginViewModel>().passController,hintText: 'Password', prefixIcon: SvgPicture.asset(AppImages.passIcon),suffixIcon: InkWell(onTap: (){
                    lVM.togglePass();},child: lVM.obs?Icon(Icons.remove_red_eye_outlined,color: Colors.white,):SvgPicture.asset(AppImages.eyeOffIcon)), validator: (val ) {return null; }, onChanged: (val ) {  },obs: lVM.obs,);

                } ),
                      SizedBox(height: 8.h,),
                    Align(alignment:Alignment.topRight,child: Text("Forgot password?",style: Theme.of(context).textTheme.bodyLarge,)),
                    SizedBox(height: 24.h,),
                    Consumer<LoginViewModel>(
                      builder: (context,lVM,_){
                        return lVM.isLoading?const CustomLoader(): CustomButton(text: "Sign in",
                          onPressed: ()async{
                           lVM.validateForm();
                            if(lVM.emailError!=null){
                              FLushBarHelper.flushBarErrorMessage(lVM.emailError!, context,FlushbarPosition.TOP);
                            }
                            else if(lVM.passController.text.isEmpty){
                              FLushBarHelper.flushBarErrorMessage("Kindly enter password", context,FlushbarPosition.TOP);

                            }
                            else{
                              await lVM.login(context);
                            }
                          },color: Colors.white.withValues(alpha: 0.84),textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),);
                
                      }, ),
                    SizedBox(height: 24.h,),
                    
                    // Row( spacing: 10,
                    //   children: [
                    //     Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.15),)),
                    //     Text("OR",style: Theme.of(context).textTheme.bodyMedium),
                    //     Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.15),)),
                    //   ],
                    // ),
                      CustomButton(text: "Sign up", onPressed: (){
             Navigator.pushNamed(context, RouteName.emailInputScreen);

           },color: Colors.white.withValues(alpha: 0.84),textStyle:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black)),

                    SizedBox(height: 24.h,),
                    // CustomButton(prefixIcon: SvgPicture.asset(AppImages.googleIcon),text: "Continue with Google", onPressed: (){},color: Colors.white.withValues(alpha: 0.20),textStyle: Theme.of(context).textTheme.bodyLarge),
                    // SizedBox(height: 8.h,),
                    // CustomButton(prefixIcon: SvgPicture.asset(AppImages.appleIcon),text: "Continue with Apple", onPressed: (){},color: Colors.white.withValues(alpha: 0.20),textStyle: Theme.of(context).textTheme.bodyLarge),
                    // SizedBox(height: 30.h),
                  ],
                  ),
              ),
              )
              ),
          );
        }
      ),
    );
  }
}
