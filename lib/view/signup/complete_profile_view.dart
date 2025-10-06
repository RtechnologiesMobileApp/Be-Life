
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../config/routes/route_names.dart';
import '../../res/components/background.dart';
import '../../res/components/custom_app_bar.dart';
import '../../res/components/custom_btn.dart';
import '../../res/components/custom_linear_progress_bar.dart';
import '../../res/components/custom_text_field.dart';
import '../../utils/flushbar_helper.dart';
import '../../view_model/auth/signup_view_model.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key});

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
            CustomLinearProgressBar(value: 1.0),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     SizedBox(height: 24.h,),
                    Align(alignment:Alignment.topLeft,child: Text("Complete your profile!",style: Theme.of(context).textTheme.headlineMedium,)),
                    SizedBox(height: 8.h,),
                    Align(alignment:Alignment.topLeft,child: Text("Add your profile image and username to your profile",style: Theme.of(context).textTheme.bodyLarge!.copyWith(letterSpacing: -0.5,height: 1.2),)),
                    SizedBox(height: 52.h,),
                      Stack(
                        children: [
                          InkWell(
                            onTap:()async{
                              await  sVM.pickImage(context);
                            },
                            child: Selector<SignupViewModel,XFile?>(
                              selector: (_,sVM)=>sVM.profilePic,
                              builder: (_,profilePic,_){
                                return  profilePic==null?Container(height: 154.h,width: 154.w,decoration: BoxDecoration(borderRadius: BorderRadius.circular(95.r),
                                  border: Border.all(color: Colors.white)
                                ),child: Icon(Icons.upload,color: Colors.white,size: 50.h,),):   Container(height: 154.h,width: 154.w,decoration: BoxDecoration(borderRadius: BorderRadius.circular(95.r),color: Colors.black,
                                    image: DecorationImage(
                                      image: FileImage(File(sVM.profilePic!.path)),
                                      fit: BoxFit.cover,
                                    )),);
                              },
                            ),
                          ),

                          Positioned( right: 0,bottom: 0,
                              child: SvgPicture.asset(AppImages.imagePickIcon,height: 40,width: 40,fit: BoxFit.cover,)),
                        ],
                      ),
                    SizedBox(height: 32.h),
                    CustomTextField(enabled: false,hintText: "${sVM.firstNameController.text} ${sVM.lastNameController.text}", prefixIcon: SvgPicture.asset(AppImages.userIcon), validator: (val ) {return null; }, onChanged: (val ) {  },),
                    SizedBox(height: 8.h),
                    CustomTextField(controller: sVM.usernameController,hintText: 'Enter username', prefixIcon: SvgPicture.asset(AppImages.atIcon), validator: (val ) {return null; }, onChanged: (val ) {  },),
                      const Spacer(),
                    Selector<SignupViewModel,bool>(
                        selector: (_,sVM)=>sVM.isLoading,
                      builder: (_,loading,_){
                          return loading?CustomLoader(): CustomButton(text: "Create Account", onPressed: ()async{
                            sVM.validateForm();
                            if(sVM.userNameError!=null){
                              FLushBarHelper.flushBarErrorMessage(sVM.userNameError!, context,FlushbarPosition.TOP);
                            } else {
                              await sVM.createAccount(context);
                            }
                          },color: Colors.white.withValues(alpha: 0.84,),textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),);

                      },
                    ),
                        SizedBox(height: 32.h),
                  ],),
              ),
            ),
          ],
        ),)),
    );
  }
}
