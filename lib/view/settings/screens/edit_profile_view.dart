import 'dart:ui';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/settings/screens/widgets/edit_pass_field.dart';
import 'package:be_life_style/view/settings/screens/widgets/profile_pic_widget.dart';
import 'package:be_life_style/view/settings/screens/widgets/shimmer/profile_pic_shimmer.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../res/components/background.dart';
import '../../../res/components/custom_text_field.dart';



class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:AppBar(centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Text("Edit profile",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700,fontSize: 18.sp),),
      ),
      body: Background(child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight + MediaQuery.of(context).padding.top),

              Consumer<ProfileViewModel>(
                builder: (context,pVM,_) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            pVM.isLoading?ProfilePicShimmer():ProfilePicWidget(imageUrl: pVM.userDetails!.profilePicture,),
                            SizedBox(height: 32.h),
                            CustomTextField(enabled:false,hintText: "${pVM.userDetails!.firstName} ${pVM.userDetails!.lastName}", prefixIcon: SvgPicture.asset(AppImages.userIcon), validator: (val ) {return null; }, onChanged: (val ) {  },),
                            SizedBox(height: 8.h),
                            CustomTextField(enabled:false,hintText: pVM.userDetails!.username, prefixIcon: SvgPicture.asset(AppImages.atIcon), validator: (val ) {return null; }, onChanged: (val ) {  },),
                            SizedBox(height: 8.h),
                           ClipRRect(
                             child: BackdropFilter(
                               filter: ImageFilter.blur(sigmaY: 40,sigmaX: 40),
                               child: Container(height: 96.h,

                                             padding: EdgeInsets.symmetric(horizontal: 16.w),
                                 decoration: BoxDecoration(
                                   color: Colors.white.withValues(alpha: 0.13),
                                   borderRadius: BorderRadius.circular(12),),
                                             child: Center(child: Text("Adventure seeker 🌍 | Travel enthusiast ✈️ | Sharing the world's most beautiful destinations 🌄",style: Theme.of(context).textTheme.bodyLarge,)),
                               ),
                             ),
                           ),
                            SizedBox(height: 24.h),
                            Align(alignment: Alignment.topLeft,
                                child: Text("Change email",style: Theme.of(context).textTheme.bodyLarge,)),
                            SizedBox(height: 16.h),
                            CustomTextField(hintText: 'Enter Email', prefixIcon: SvgPicture.asset(AppImages.emailIcon), validator: (val ) {return null; }, onChanged: (val ) {  },suffixIcon: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 17.h,),),
                            SizedBox(height: 24.h),
                            Align(alignment: Alignment.topLeft,
                                child: Text("Change password",style: Theme.of(context).textTheme.bodyLarge,)),
                            SizedBox(height: 16.h),
                            EditPassField(),
                            SizedBox(height: 24.h),

                                 ],),
                      ),
                    ],
                  );
                }
              ),
            ],
          ),
        ),)),
    );
  }
}
