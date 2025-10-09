// import 'package:be_life_style/config/routes/route_names.dart';
// import 'package:be_life_style/view/home/screens/widgets/top_tabs.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class TopSection extends StatelessWidget {
//   const TopSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TopTab(text: "Discover",index:  0),
//                 TopTab(text: "For you", index: 1),
//                 Stack(
//                   children: [

//                     TopTab(text: "Following", index: 2),
//                     // Positioned(right: 0,
//                     //     top: 0,
//                     //     child: Icon(Icons.circle,color: Color(0xFFFF4000),size: 8.h,)),
//                   ],
//                 ),
//               ],
//             ),

//             // Search Icon
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8.0),

//               child: InkWell(onTap: (){
//                 Navigator.pushNamed(context, RouteName.searchScreen);
//               },child: Icon(CupertinoIcons.search, color: Colors.white, size: 24)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

 
 import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/view/home/screens/widgets/top_tabs.dart';
import 'package:be_life_style/view_model/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),

        // 👇 Directly listen to HomeViewModel
        child: Consumer<HomeViewModel>(
          builder: (context, hVm, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 👇 Tabs
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TopTab(text: "Discover", index: 0),
                    TopTab(text: "For you", index: 1),
                    Stack(
                      children: [
                        TopTab(text: "Following", index: 2),
                        // Positioned(
                        //   right: 0,
                        //   top: 0,
                        //   child: Icon(
                        //     Icons.circle,
                        //     color: const Color(0xFFFF4000),
                        //     size: 8.h,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),

                // 👇 Search Icon color based on selected tab
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 8.0),
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.pushNamed(context, RouteName.searchScreen);
                //     },
                //     child: Icon(
                //       CupertinoIcons.search,
                //       // 👇 Discover tab -> black | others -> white
                //       color: hVm.selectedIndex == 0
                //           ? Colors.black
                //           : Colors.white,
                //       size: 24,
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
