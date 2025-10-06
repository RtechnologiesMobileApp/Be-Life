import 'package:be_life_style/view/search/widgets/bottom_btn.dart';
import 'package:be_life_style/view/search/widgets/header_section.dart';
import 'package:be_life_style/view/search/widgets/media_widget.dart';
import 'package:be_life_style/view/search/widgets/reviews_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PlaceInfoView extends StatelessWidget {
  const PlaceInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:  AppBar(
       scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
               HeaderSection(),
                SizedBox(height: 4.h,),
                ReviewsSection(),

                SizedBox(height: 11.h,),
                Container(height: 5.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xFFEAEBEB),borderRadius: BorderRadius.circular(4)),
                ),

                SizedBox(height: 4.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Align(alignment: Alignment.topLeft,
                      child: Text("Posts",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 18.sp,color: Colors.black),)),
                ),
                SizedBox(height: 4.h,),
                MediaWidget(),
                SizedBox(height: 105.h,)
              ],
            ),
          ),
          Positioned(bottom: 0,
              right: 0,
              left: 0,
              child: BottomBtn())
        ],
      ),
    );
  }
}
