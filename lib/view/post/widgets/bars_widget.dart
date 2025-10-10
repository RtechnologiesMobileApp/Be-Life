 

import 'package:be_life_style/view/post/widgets/add_link_bottom_sheet.dart';
import 'package:be_life_style/view/post/widgets/tag_people_bottom_sheet.dart';
import 'package:be_life_style/view_model/videos/post_video_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_images.dart';
import 'custom_bar.dart';

class BarsWidget extends StatelessWidget {
  const BarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Location

        // ✅ Location
Consumer<PostVideoViewModel>(
  builder: (context, viewModel, _) {
    return CustomBar(
      leading: SvgPicture.asset(
        AppImages.locIcon,
        height: 20.h,
        width: 20.h,
        fit: BoxFit.cover,
        color: Colors.black,
      ),
      title: "Location",
      trailing: InkWell(
        onTap: () async {
          await viewModel.getCurrentLocation();
        },
        child: Icon(
          Icons.my_location,
          size: 18.h,
          color: const Color(0xFF696969),
        ),
      ),
      subTitle: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF6F6F6),
        ),
        height: 28.h,
        margin: EdgeInsets.only(top: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on_outlined,
                color: Color(0xFFB0B0B0), size: 16),
            SizedBox(width: 4.w),
            Text(
              viewModel.currentLocation ?? "Add location",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 14.sp,
                    color: viewModel.currentLocation == null
                        ? const Color(0xFFB0B0B0)
                        : Colors.black,
                  ),
            ),
           SizedBox(width: 8.w),
            Text(
  viewModel.detectedPlace ?? "No specific place",
  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Colors.grey,
        fontSize: 12.sp,
      ),
),
          ],
        ),
      ),
    );
  },
),

      
        // ✅ Visibility
        CustomBar(
          leading: Icon(Icons.remove_red_eye_outlined),
          title: "Visibility",
          trailing: SizedBox(
            height: 24.h,
            width: 48.w,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Selector<PostVideoViewModel, bool>(
                selector: (_, pVM) => pVM.visibility,
                builder: (_, visibility, __) {
                  return CupertinoSwitch(
                    activeTrackColor: Color(0xFF202020),
                    value: visibility,
                    onChanged: (val) {
                      context.read<PostVideoViewModel>().toggleVisibility();
                    },
                  );
                },
              ),
            ),
          ),
          subTitle: Text(
            "Public or friends only videos",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 14.sp, color: Color(0xFF696969)),
          ),
        ),

        // ✅ Tag people
        // Consumer<PostVideoViewModel>(
        //   builder: (context, viewModel, child) {
        //     return CustomBar(
        //       leading: SvgPicture.asset(
        //         AppImages.addUser,
        //         height: 20.h,
        //         width: 20.h,
        //         fit: BoxFit.cover,
        //         color: Colors.black,
        //       ),
        //       title: "Tag people",
        //       trailing: InkWell(
        //         onTap: () {
        //           showModalBottomSheet(
        //             isScrollControlled: true,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        //             ),
        //             backgroundColor: Colors.white,
        //             context: context,
        //             builder: (context) => TagPeopleBottomSheet(
        //               taggedUsers: viewModel.taggedUsers,
        //               onTaggedUsersChanged: (users) {
        //                 viewModel.updateTaggedUsers(users);
        //               },
        //             ),
        //           );
        //         },
        //         child: Icon(
        //           Icons.arrow_forward_ios,
        //           size: 18.h,
        //           color: Color(0xFF696969),
        //         ),
        //       ),
        //       subTitle: viewModel.taggedUsers.isEmpty
        //           ? Container(
        //               margin: EdgeInsets.only(top: 12.h),
        //               height: 28.h,
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(8),
        //                 color: Color(0xFFF6F6F6),
        //               ),
        //               child: Center(
        //                 child: Text(
        //                   "Tag friends",
        //                   style: Theme.of(context)
        //                       .textTheme
        //                       .bodyLarge!
        //                       .copyWith(fontSize: 14.sp, color: Color(0xFFB0B0B0)),
        //                 ),
        //               ),
        //             )
        //           : Container(
        //               margin: EdgeInsets.only(top: 12.h),
        //               child: Wrap(
        //                 spacing: 8.w,
        //                 runSpacing: 4.h,
        //                 children: viewModel.taggedUsers.map((user) {
        //                   return Container(
        //                     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        //                     decoration: BoxDecoration(
        //                       color: Colors.blue,
        //                       borderRadius: BorderRadius.circular(12.r),
        //                     ),
        //                     child: Row(
        //                       mainAxisSize: MainAxisSize.min,
        //                       children: [
        //                         Text(
        //                           '${user.firstName} ${user.lastName}',
        //                           style: TextStyle(
        //                             color: Colors.white,
        //                             fontSize: 12.sp,
        //                           ),
        //                         ),
        //                         SizedBox(width: 4.w),
        //                         GestureDetector(
        //                           onTap: () => viewModel.removeTaggedUser(user),
        //                           child: Icon(
        //                             Icons.close,
        //                             color: Colors.white,
        //                             size: 14.h,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   );
        //                 }).toList(),
        //               ),
        //             ),
        //     );
        //   },
        // ),

        // ✅ Add Links
        // CustomBar(
        //   leading: SvgPicture.asset(
        //     AppImages.linksIcon,
        //     height: 20.h,
        //     width: 20.h,
        //     fit: BoxFit.cover,
        //     color: Colors.black,
        //   ),
        //   title: "Add Links",
        //   trailing: InkWell(
        //     onTap: () {
        //       showModalBottomSheet(
        //         isScrollControlled: true,
        //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        //         backgroundColor: Colors.white.withValues(alpha: 0.98),
        //         context: context,
        //         builder: (context) => AddLinkBottomSheet(),
        //       );
        //     },
        //     child: Icon(
        //       Icons.arrow_forward_ios,
        //       size: 18.h,
        //       color: Color(0xFF696969),
        //     ),
        //   ),
        //   subTitle: Container(
        //     height: 12.h,
        //   ),
        // ),

        // ✅ More options
        // CustomBar(
        //   leading: SvgPicture.asset(
        //     AppImages.linksIcon,
        //     height: 20.h,
        //     width: 20.h,
        //     fit: BoxFit.cover,
        //     color: Colors.black,
        //   ),
        //   title: "More options",
        //   trailing: Icon(
        //     Icons.more_horiz_rounded,
        //     size: 18.h,
        //     color: Color(0xFF696969),
        //   ),
        //   subTitle: Container(
        //     height: 14.h,
        //   ),
        // ),
      ],
    );
  }
}
