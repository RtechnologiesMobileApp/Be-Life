
import 'package:another_flushbar/flushbar.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/signup/widgets/pass_input_field.dart';
import 'package:be_life_style/view/signup/widgets/pass_validations.dart';
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
import '../../utils/flushbar_helper.dart';

class CreatePassView extends StatelessWidget {
  const CreatePassView({super.key});

  @override
  Widget build(BuildContext context) {
    final sVM= context.read<SignupViewModel>();
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
            CustomLinearProgressBar(value: 0.75),
            SizedBox(height: 24.h,),
            Align(alignment:Alignment.topLeft,child: Text("Create a strong password",style: Theme.of(context).textTheme.headlineMedium,)),
            SizedBox(height: 32.h,),
        Selector<SignupViewModel,bool>(
          selector: (_,sVM)=>sVM.obs,
          builder: (_, obs,child) {
            return Column(children: [
              PassInputField(obs: obs,hintText: 'Enter Password', suffixIcon: InkWell(
                  onTap:() => context.read<SignupViewModel>().togglePass() , child:obs?Icon(Icons.remove_red_eye_outlined,color: Colors.white,): SvgPicture.asset(AppImages.eyeOffIcon)), validator: (val ) {return null; }, onChanged: (val ) {sVM.validatePass();}, controller: sVM.passController,),
              SizedBox(height: 8.h,),
              PassInputField(controller: sVM.cPassController,obs: obs,hintText: 'Confirm Password', suffixIcon:InkWell(
                  onTap:() => context.read<SignupViewModel>().togglePass() , child: obs?Icon(Icons.remove_red_eye_outlined,color: Colors.white,):SvgPicture.asset(AppImages.eyeOffIcon)), validator: (val ) {return null; }, onChanged: (val ) {  },),],) ;  },
        ),
            SizedBox(height: 18.h,),
            PassValidationWidget(),
            const Spacer(),
            CustomButton(text: "Done", onPressed: (){
              sVM.validateForm();
              if(sVM.passError==null){
                Navigator.pushNamed(context, RouteName.interestsPickerScreen);
              }
              else{
                FLushBarHelper.flushBarErrorMessage(sVM.passError!, context,FlushbarPosition.TOP);
              }
            },color: Colors.white.withValues(alpha: 0.84,),textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),),
            SizedBox(height: 32.h),
          ],),)),
    );
  }
}
