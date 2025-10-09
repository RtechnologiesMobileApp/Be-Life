import 'package:be_life_style/view_model/main_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_images.dart';
import '../../../view_model/videos/post_video_view_model.dart';


class BottomNav extends StatelessWidget {
  const BottomNav({super.key});
  
  @override
  Widget build(BuildContext context) {

    return Consumer<MainNavViewModel>(
      builder: (context,pr,child) {
        return Theme(
          data: ThemeData(useMaterial3: false),
          child: BottomNavigationBar(
            onTap: (index)async{
              if(index==2){
              await context.read<PostVideoViewModel>().pickVideo().then((val){
                if(context.mounted){
                if(context.read<PostVideoViewModel>().pickedVideo!=null){
                pr.changeIndex(index);
                }
                }
              });
              }
              else{
              pr.changeIndex(index);}
            },
            iconSize: 24.h,
            selectedLabelStyle: TextStyle(height: 1.5.h),
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            elevation: 0,
            currentIndex: pr.selectedIndex,
            selectedItemColor: Colors.black,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              items:[
                BottomNavigationBarItem(icon: SizedBox(height:24.h,width:24.w,child: SvgPicture.asset(AppImages.homeIcon,fit: BoxFit.cover,colorFilter: ColorFilter.mode(
                  pr.selectedIndex == 0 ? Colors.black : Color(0xFFA7A7A7),
                  BlendMode.srcIn,
                ),)), label: 'Home',),
                BottomNavigationBarItem(
  icon: SizedBox(
    height: 24.h,
    width: 24.w,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          AppImages.msgIcon,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            pr.selectedIndex == 1 ? Colors.black : const Color(0xFFA7A7A7),
            BlendMode.srcIn,
          ),
        ),
        if (pr.unreadCount > 0) // ✅ show only when > 0
          Positioned(
            top: -2.h,
            right: -4.w,
            child: Container(
              height: 14.h,
              width: 14.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  "${pr.unreadCount}", // ✅ dynamic count
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 8.sp,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
      ],
    ),
  ),
  label: 'Inbox',
),

        
                BottomNavigationBarItem(icon: Container(
                    height: 44.h,
                    width: 44.w,
                    margin: EdgeInsets.only(top: 10.h),
                    decoration: BoxDecoration(
                      color: Color(0xFF202020),
                      borderRadius: BorderRadius.circular(37),
                    ),child: Icon(Icons.add,color: Colors.white,)),label: ""),
              BottomNavigationBarItem(
  icon: Icon(
    Icons.explore_outlined,
    size: 24.h,
    color: pr.selectedIndex == 3 ? Colors.black : const Color(0xFFA7A7A7),
  ),
  label: 'Discover',
),

                BottomNavigationBarItem(icon: SizedBox(height:24.h,width:24.w,child: SvgPicture.asset(AppImages.userDarkIcon,fit: BoxFit.cover,colorFilter: ColorFilter.mode(
                  pr.selectedIndex == 4 ? Colors.black : Color(0xFFA7A7A7),
                  BlendMode.srcIn,
                ),)), label: 'Profile'),
              ]),
        );
      }
    );
  }
}
