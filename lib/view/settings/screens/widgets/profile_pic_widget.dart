import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_images.dart';
class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key, required this.imageUrl});
final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: (){
          context.read<ProfileViewModel>().updateProfilePic(context);
        },
        child: Stack(
          children: [
            SizedBox(
              height: 110.h,
              width: 110.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(98.r),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
  right: 0,
  bottom: 0,
  child: Container(
    height: 30,
    width: 30,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.black, // optional background for visibility
    ),
    child: const Center(
      child: Icon(
        Icons.camera_alt,
        size: 22,
        color: Colors.white,
      ),
    ),
  ),
),

            // Positioned(
            //   right: 0,
            //   bottom: 0,
            //   child: SvgPicture.asset(
            //     AppImages.imagePickIcon,
            //     height: 40,
            //     width: 40,
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ],
        ),
      );
  }
}
