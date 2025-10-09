import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/view/profile/widgets/settings_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return     Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Profile",
            style: Theme.of(context).textTheme.headlineMedium!
                .copyWith(fontSize: 18.sp, color: Colors.black)),
        InkWell(
          onTap: (){
               Navigator.pushNamed(context, RouteName.settingsScreen);
            // showModalBottomSheet(
            //   showDragHandle: true,
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            //     backgroundColor: Colors.white.withValues(alpha: 0.98),
            //     context: context, builder: (context)=>SettingsBottomSheet());

          },
          child: SizedBox(
              height: 40.h,
              width: 40.w,
              child: CircleAvatar(
                backgroundColor: Color(0xFFF6F6F6),
                child: Center(child: Icon(Icons.menu)),
              )),
        ),
      ],
    );
  }
}
