import 'dart:ui';

import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/model/search_item_model.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/search/widgets/place_card_widget.dart';
import 'package:be_life_style/view/search/widgets/search_top_bar.dart';
import 'package:be_life_style/view_model/search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_)=>SearchViewModel(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
            child: Column(
              children: [
              GestureDetector(onTap: (){
                Navigator.pushNamed(context, RouteName.searchTabScreen);
              },child: SearchTopBar(isEnabled: false,)),
              SizedBox(height: 16.h,),
              
              // User Search Button
              _buildUserSearchButton(context),
              SizedBox(height: 16.h,),
              
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Suggested for you \"Cozy corner\"",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    height: 20/16.sp,
                  ),
                ),
              ),
                SizedBox(height: 16.h,),
              Consumer<SearchViewModel>(
                builder: (context,sVM,child) {
                  return Expanded(child: ListView.builder(
                    itemCount: sVM.items.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context,index){
                      SearchItemModel item=sVM.items[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: InkWell(onTap: (){
                          Navigator.pushNamed(context, RouteName.placeInfoScreen);
                        },
                          child: PlaceCardWidget(title: item.name, pP: item.usrPic, subTitle: item.subTitle, img: item.img),
                        ),
                      );
                    },
                  ));
                },
              )

              ],),

          ),
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
        width: double.infinity,
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
                Icons.person_search,
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
                    'Search for users and connect with them',
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
