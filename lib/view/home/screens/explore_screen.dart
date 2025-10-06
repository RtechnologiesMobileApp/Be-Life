import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view_model/explore_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (_)=>ExploreViewModel(),
        child: SafeArea(
          child: Column(
            children: [
              Padding( padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical:28.0.h),
              ),
              Expanded(
                child: Consumer<ExploreViewModel>(
                  builder: (context,exVM,child) {
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: MasonryGridView.builder(
                        itemCount: exVM.places.length,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 4,
                          padding: EdgeInsets.zero,
                          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,), itemBuilder: (context,index)=>Column(


                            children: [
                              SizedBox(width: double.infinity,child: ClipRRect(borderRadius: BorderRadius.circular(16),child: Image.asset(exVM.places[index].img,fit: BoxFit.cover,))),
                              SizedBox(height: 6.h,),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(AppImages.pp3, height: 16, width: 16, fit: BoxFit.cover),
                                  ),
                                  SizedBox(width: 6.w), // Adjust spacing manually
                                  Text(
                                    exVM.places[index].name,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp, color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h,),

                              Row(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                InkWell(onTap: (){
                                  exVM.toggleFav(index);
                                },child: Icon( exVM.places[index].isLiked?CupertinoIcons.heart_fill:CupertinoIcons.heart,color:exVM.places[index].isLiked? Colors.red:Color(0xFF868686),size: 16,)),
                                SizedBox(width: 3.w,),
                                Text("211.5k",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: Colors.black),),
                                SizedBox(width: 8.w,),
                                Icon(CupertinoIcons.chat_bubble,color: Color(0xFF868686),size: 16,),
                                SizedBox(width: 3.w,),
                                Text("7.9k",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: Colors.black),)

                              ],),
                              SizedBox(height: 10.h,),

                            ],
                          )),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

}
