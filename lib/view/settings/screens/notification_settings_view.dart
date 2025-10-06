import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/settings/screens/widgets/custom_setting_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NotificationsSettingsView extends StatelessWidget {
  const NotificationsSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text("Notification settings",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700,color: Colors.black),),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          CustomSettingBar(leading: AppImages.calendarIcon, title: 'Booking Confirmations', subTitle: "Receive notifications for booking confirmation",
          trailing:  SizedBox(height:24.h,width:48.w,child: FittedBox(
              fit: BoxFit.contain,
              child: CupertinoSwitch(activeTrackColor: Color(0xFF202020) ,value: false, onChanged: (val){}))),
          ),
          SizedBox(height: 8.h,),
            CustomSettingBar(leading: AppImages.heartOutline, title: 'Social Interactions', subTitle: "Get notified for likes, comments, and follows",
              trailing:  SizedBox(height:24.h,width:48.w,child: FittedBox(
                  fit: BoxFit.contain,
                  child: CupertinoSwitch(activeTrackColor: Color(0xFF202020) ,value: true, onChanged: (val){}))),
            ),
            SizedBox(height: 8.h,),
            CustomSettingBar(leading: AppImages.giftIcon, title: 'Recommendations and Offers', subTitle: "Personalized recommendations & special offers",
              trailing:  SizedBox(height:24.h,width:48.w,child: FittedBox(
                  fit: BoxFit.contain,
                  child: CupertinoSwitch(activeTrackColor: Color(0xFF202020) ,value: false, onChanged: (val){}))),
            ),
            SizedBox(height: 8.h,),
            CustomSettingBar(leading: AppImages.bellIcon, title: 'General Announcements', subTitle: "Stay updated with app announcements",
              trailing:  SizedBox(height:24.h,width:48.w,child: FittedBox(
                  fit: BoxFit.contain,
                  child: CupertinoSwitch(activeTrackColor: Color(0xFF202020) ,value: false, onChanged: (val){}))),
            ),
            SizedBox(height: 21.h,),
          ],),
      ),
    );
  }
}
