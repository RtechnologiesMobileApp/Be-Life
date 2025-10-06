import 'package:be_life_style/view_model/main_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/app_images.dart';
class DirectMsgWidget extends StatelessWidget {
  const DirectMsgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavViewModel>(
      builder: (context, mainNav, child) {
        return InkWell(
          onTap: () {
            // Reset counter when DirectMsgWidget is clicked
            mainNav.resetUnread();
            Navigator.pushNamed(context, RouteName.directMsgScreen);
          },
          child: Row(children: [
            SvgPicture.asset(AppImages.directMsg,fit: BoxFit.cover,height: 40.h,width: 40.h,),
            SizedBox(width: 8.w,),
            Text("Direct message",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: Colors.black),),
            SizedBox(width: 4.w,),
            if (mainNav.unreadCount > 0)
              Container(height: 20.h,width: 20.w,
                decoration: BoxDecoration(
                    color: Color(0xFFFF534D),
                    borderRadius: BorderRadius.circular(16)
                ),
                child: Center(child: Text("${mainNav.unreadCount}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10.sp, color: Colors.white),),),),
            const Spacer(),
            Icon(Icons.arrow_forward_ios,color: Color(0xFFCCCCCC),size: 20.h,)
          ],),
        );
      }
    );
  }
}
