import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/settings/screens/widgets/custom_setting_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PrivacySecurityView extends StatelessWidget {
  const PrivacySecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text("Privacy and Security",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700,color: Colors.black),),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSettingBar(leading: AppImages.calendarIcon, title: 'Account Visibility',
              subTitle: "Control who can see your profile and activity e.g., Public, Friends, Only Private",
              trailing:  SizedBox(height:24.h,width:48.w,child: FittedBox(
                  fit: BoxFit.contain,
                  child: CupertinoSwitch(activeTrackColor: Color(0xFF202020) ,value: true , onChanged: (val){}))),
            ),
            SizedBox(height: 8.h,),
            CustomSettingBar(leading: AppImages.blockedIcon, title: 'Manage Blocked Accounts', subTitle: "View Blocked Accounts",
              trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF696969),size: 17.h,)      ),
            SizedBox(height: 8.h,),
            CustomSettingBar(leading: AppImages.termsIcon, title: 'Terms and Conditions', subTitle: "Read Terms & Conditions",
                trailing: Icon(Icons.arrow_forward_ios,color: Color(0xFF696969),size: 17.h,)      ),
            SizedBox(height: 8.h,),


          ],),
      ),
    );
  }
}
