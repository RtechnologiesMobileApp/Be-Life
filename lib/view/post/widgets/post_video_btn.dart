import 'dart:ui';

import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/utils/flushbar_helper.dart';
import 'package:be_life_style/view_model/videos/post_video_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../res/components/custom_btn.dart';
import '../../../view_model/main_nav_view_model.dart';

class PostVideoBtn extends StatelessWidget {
  const PostVideoBtn({super.key});
  @override
  Widget build(BuildContext context) {
    return  Selector<PostVideoViewModel,bool>(
      selector: (_,pVM)=>pVM.isLoading,
      builder: (_,isLoading,_) {
     
       return isLoading?CustomLoader(): CustomButton(text: "Post",
            onPressed: () async{
         await context.read<PostVideoViewModel>().postVideo();
         if(context.mounted){
           context.read<PostVideoViewModel>().clearData();
          context.read<MainNavViewModel>().changeIndex(0);
         FLushBarHelper.flushBarSuccessMessage("Video Posted Successfully", context);
         }
            },
            height: 56.h,
            width: 162.w,
            color: Color(0xFF202020,));
      } );
       }
}
