import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_images.dart';
import '../../../view_model/auth/signup_view_model.dart';

class ObsWidget extends StatelessWidget {
  const ObsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:() => context.read<SignupViewModel>().togglePass() ,
        child: SvgPicture.asset(AppImages.eyeOffIcon));
  }
}
