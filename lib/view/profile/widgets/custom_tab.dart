import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({super.key, required this.icon, required this.index});
 final String icon;
 final int index;
  @override
  Widget build(BuildContext context) {
    return  Consumer<ProfileViewModel>(
      builder: (context,pVM,child) {
        return GestureDetector(
          onTap: () {
            pVM.changeTab(index);
          },
          child: SizedBox(
              height: 37.h,
              width: 124.w,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(icon,fit: BoxFit.cover,height: 24.h,width: 24.w,color:pVM.selectedIndex==index?Color(0xFF202020):Color(0xFF696969),),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.only(top: 5.h),
                    height: 1.h,
                    width: pVM.selectedIndex==index  ? 56.w : 0,
                    color: Color(0xFF202020),
                  ),
                   ],
              )),
        );
      }
    );
  }
}
