import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/settings/widgets/setting_bar.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:be_life_style/config/api_endpoints.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//             Consumer<ProfileViewModel>(
//   builder: (context, pVM, _) {
//     if (pVM.userDetails == null) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     return ListTile(
//       minVerticalPadding: 0,
//       contentPadding: EdgeInsets.zero,
//       leading: SizedBox(
//         height: 46.h,
//         width: 46.h,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(1000.r),
//           child: CachedNetworkImage(
//             fit: BoxFit.cover,
//             imageUrl: pVM.userDetails!.profilePicture,
//             progressIndicatorBuilder: (context, url, downloadProgress) =>
//                 CircularProgressIndicator(value: downloadProgress.progress),
//             errorWidget: (context, url, error) => const Icon(Icons.error),
//           ),
//         ),
//       ),
//       title: Text(
//         pVM.userDetails!.firstName,
//         style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//           fontSize: 18.sp,
//           color: Colors.black,
//         ),
//       ),
//       subtitle: Text(
//         pVM.userDetails!.email,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//           fontSize: 14.sp,
//           color: const Color(0xFF797979),
//         ),
//       ),
//       trailing: InkWell(
//         onTap: () {
//           Navigator.pushNamed(context, RouteName.editProfileScreen);
//         },
//         child: Container(
//           width: 93.w,
//           height: 40.h,
//           decoration: BoxDecoration(
//             color: const Color(0xFFF6F6F6),
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: Center(
//             child: Text(
//               "Edit Profile",
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontSize: 14.sp,
//                 color: const Color(0xFF202020),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   },
// ),

            Consumer<ProfileViewModel>(
              builder: (context, pVM, _) {
                return ListTile(
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(
                    height: 46.h,
                    width: 46.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000.r),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: pVM.userDetails!.profilePicture,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  title: Text(
                    pVM.userDetails!.firstName,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    pVM.userDetails!.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xFF797979),
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.editProfileScreen);
                    },
                    child: Container(
                      width: 93.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(
                            fontSize: 14.sp,
                            color: Color(0xFF202020),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
         
         
            SizedBox(height: 10.h),
            SettingBar(
              text: "Notification settings",
              img: AppImages.notificationIcon,
              func: () {
                Navigator.pushNamed(
                  context,
                  RouteName.notificationsSettingsView,
                );
              },
            ),
            SettingBar(
              text: "Privacy and Security",
              img: AppImages.lockIcon,
              func: () {
                Navigator.pushNamed(context, RouteName.privacySecurityView);
              },
            ),
            SettingBar(text: "About app", img: AppImages.infoIcon, func: () {}),
            SettingBar(
              text: "Help center",
              img: AppImages.questionIcon,
              func: () {
                Navigator.pushNamed(context, RouteName.helpCenterScreen);
              },
            ),

//  SettingBar(
//   text: "Link Email",
//   img: AppImages.eamilIconblack, // use Flutter icon
//   color: Colors.black,
//   func: () async {
//     try {
//       final session = SessionController();
//       await session.getUserInPreference(); // Load user data
//       final userId = session.id;

//       if (userId == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("User ID not found. Please log in again."),
//             backgroundColor: Colors.redAccent,
//           ),
//         );
//         return;
//       }

//       final url = Uri.parse(
//         "${ApiEndpoints.baseUrl}/email/gmail/auth?userId=$userId",
//       );

//       // Check if the link can be launched
//       if (await canLaunchUrl(url)) {
//         final launched = await launchUrl(
//           url,
//           mode: LaunchMode.externalApplication, // Opens in Chrome/Safari
//         );
//         if (!launched) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Could not open the link."),
//               backgroundColor: Colors.redAccent,
//             ),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Could not open the link."),
//             backgroundColor: Colors.redAccent,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Error: $e"),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//     }
//   },
// ),


            SettingBar(
              text: "Logout",
              img: AppImages.logoutIcon,
              color: Color(0xFFFF4E4E),
              func: () {
                SessionController().clearSession();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteName.welcomeScreen,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
