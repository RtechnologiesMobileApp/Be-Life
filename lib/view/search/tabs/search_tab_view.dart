import 'package:be_life_style/view/search/tabs/stays_tab.dart';
import 'package:be_life_style/view/search/tabs/todo_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_images.dart';
import '../../../view_model/search_view_model.dart';
import 'widgets/box_widget.dart';
import '../widgets/search_top_bar.dart';
import 'flights_tab.dart';
class SearchTabView extends StatelessWidget {
  const SearchTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_)=>SearchViewModel(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
            child: Column(children: [
              SearchTopBar(),
              SizedBox(height: 12.h,),
              Row(
                children: [
                  Flexible(child: BoxWidget(icon: AppImages.todoIcon, text: "Things to Do", index: 0,)),
                  SizedBox(width: 7.w,),
                  Flexible(child: BoxWidget(icon: AppImages.staysIcon, text: "Stays", index: 1,)),
                  SizedBox(width: 7.w,),
                  Flexible(child: BoxWidget(icon: AppImages.flightIcon, text: "Flights", index: 2,)),
                ],),
              Consumer<SearchViewModel>(
                builder: (context, sVM, child) {
                  return Expanded(
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(), // Prevent direct swiping
                      controller: sVM.pageController,
                      children: [
                        TodoTab(),
                        StaysTab(),
                        FlightsTab(),
                      ],
                    ),
                  );
                },
              ),
            ],),
      
          ),
        ),
      ),
    );
  }
}
