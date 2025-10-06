import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/inbox/widgets/chat_card.dart';
import 'package:be_life_style/view/inbox/widgets/direct_msg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InboxView extends StatelessWidget {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 16.w,top: 15.h,right: 16.w),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Inbox",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),),
            SizedBox(height:24.h ,),
           DirectMsgWidget(),
           SizedBox(height: 16.h),
           _buildUserSearchButton(context),
              // SizedBox(height:24.h ,),
              // Text("Activity",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 16.sp,color: Colors.black),),
              // SizedBox(height:16.h ,),
              // ChatCard(img: AppImages.msgP1, name: "Alex chen", time: "3m ago", subTitle: "Liked your experience", subTitle2: '“Sunset yoga at central park ” ', isDirect:true),
              // SizedBox(height:20.h ,),
              // ChatCard(img: AppImages.msgP2, name: "Maria Garcia", time: "1d ago", subTitle: "", subTitle2: 'Just started following you. ', isDirect:true),
              // SizedBox(height:20.h ,),
              // ChatCard(img: AppImages.msgP3, name: "James wilson", time: "1d ago", subTitle: "Liked your experience ", subTitle2: '“Food tour in little italy” ', isDirect:false),
              // SizedBox(height:20.h ,),
              // ChatCard(img: AppImages.msgP4, name: "Emma Thomson", time: "1d ago", subTitle: "", subTitle2: 'Just started following you. ', isDirect:false),
              // SizedBox(height:20.h ,),
              // ChatCard(img: AppImages.msgP5, name: "Sam Lee", time: "1d ago", subTitle: "Replied your comment ", subTitle2: '“Thats amazing place to be in 🔥🔥”', isDirect:false),
              // SizedBox(height:20.h ,),
              // ChatCard(img: AppImages.msgP6, name: "John", time: "1d ago", subTitle: "Replied your comment ", subTitle2: '“Thats amazing place to be in 🔥🔥”', isDirect:false),
              // SizedBox(height:20.h ,),
              // ChatCard(img: AppImages.msgP7, name: "William", time: "1d ago", subTitle: "Replied your comment ", subTitle2: '“Thats amazing place to be in 🔥🔥”', isDirect:false),
              // SizedBox(height:20.h ,),
            ],),
        ),
      ),
    );
  }

  Widget _buildUserSearchButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.userSearchScreen);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 20.h,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find People',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.blue.shade800,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Search for users and start new conversations',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.blue.shade600,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue.shade600,
              size: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
