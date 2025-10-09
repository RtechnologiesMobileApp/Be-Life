import 'dart:ui';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/settings/screens/widgets/edit_pass_field.dart';
import 'package:be_life_style/view/settings/screens/widgets/profile_pic_widget.dart';
import 'package:be_life_style/view/settings/screens/widgets/shimmer/profile_pic_shimmer.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';

import '../../../res/components/background.dart';
import '../../../res/components/custom_text_field.dart';



class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _didPrefill = false;
  String _newPassword = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didPrefill) return;
    final pVM = context.read<ProfileViewModel>();
    final user = pVM.userDetails;
    if (user != null) {
      if (_nameController.text.isEmpty) {
        _nameController.text = "${user.firstName} ${user.lastName}".trim();
      }
      if (_usernameController.text.isEmpty) {
        _usernameController.text = user.username;
      }
      if (_emailController.text.isEmpty) {
        _emailController.text = user.email;
      }
      if (_bioController.text.isEmpty) {
        _bioController.text = SessionController().bio ?? '';
      }
      _didPrefill = true;
    }
  }

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
                            CustomTextField(
                              enabled:true,
                              hintText: 'Full name',
                              prefixIcon: SvgPicture.asset(AppImages.userIcon),
                              controller: _nameController,
                              validator: (val ) {return null; },
                              onChanged: (val ) {  },
                            ),
                            SizedBox(height: 8.h),
                            CustomTextField(
                              enabled:true,
                              hintText: '@username',
                              prefixIcon: SvgPicture.asset(AppImages.atIcon),
                              controller: _usernameController,
                              validator: (val ) {return null; },
                              onChanged: (val ) {
                                // Enforce no spaces as user types; show visually what will be sent
                                final selection = _usernameController.selection;
                                final newText = val.replaceAll(' ', '');
                                if (newText != val) {
                                  _usernameController.text = newText;
                                  _usernameController.selection = selection.copyWith(
                                    baseOffset: newText.length,
                                    extentOffset: newText.length,
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 8.h),
                           ClipRRect(
                             child: BackdropFilter(
                               filter: ImageFilter.blur(sigmaY: 40,sigmaX: 40),
                               child: Container(
                                 height: 96.h,
                                 padding: EdgeInsets.symmetric(horizontal: 16.w),
                                 decoration: BoxDecoration(
                                   color: Colors.white.withValues(alpha: 0.13),
                                   borderRadius: BorderRadius.circular(12),
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     controller: _bioController,
                                     maxLines: 3,
                                     style: Theme.of(context).textTheme.bodyLarge,
                                     cursorColor: Colors.white,
                                     decoration: InputDecoration(
                                       hintText: 'Bio (optional)',
                                       hintStyle: Theme.of(context).textTheme.bodyLarge,
                                       border: InputBorder.none,
                                       focusedBorder: InputBorder.none,
                                       enabledBorder: InputBorder.none,
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           ),
                            SizedBox(height: 24.h),
                            Align(alignment: Alignment.topLeft,
                                child: Text("Change email",style: Theme.of(context).textTheme.bodyLarge,)),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              hintText: 'Email',
                              prefixIcon: SvgPicture.asset(AppImages.emailIcon),
                              enabled: false,
                              controller: _emailController,
                              validator: (val ) {return null; },
                              onChanged: (val ) {  },
                              suffixIcon: const SizedBox(),
                            ),
                            SizedBox(height: 24.h),
                            Align(alignment: Alignment.topLeft,
                                child: Text("Change password",style: Theme.of(context).textTheme.bodyLarge,)),
                            SizedBox(height: 16.h),
                            EditPassField(
                              onChanged: (pwd) {
                                setState(() { _newPassword = pwd; });
                              },
                              onSubmit: (pwd) async {
                                // Do not call API here; just store and let Update button submit everything together
                                setState(() { _newPassword = pwd; });
                              },
                            ),
                            SizedBox(height: 24.h),

                            GestureDetector(
                              onTap: pVM.isLoading
                                  ? null
                                  : () async {
                                      await context.read<ProfileViewModel>().updateProfileFields(
                                            context: context,
                                            fullName: _nameController.text,
                                            username: _usernameController.text,
                                            bio: _bioController.text,
                                            password: _newPassword.isNotEmpty ? _newPassword : null,
                                          );
                                    },
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                                  child: Container(
                                    height: 56.h,
                                    width: 346.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.13),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: pVM.isLoading
                                        ? SizedBox(
                                            height: 20.h,
                                            width: 20.h,
                                            child: const CircularProgressIndicator(strokeWidth: 2),
                                          )
                                        : Text(
                                            'Update',
                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                                          ),
                                  ),
                                ),
                              ),
                            ),

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


 
 