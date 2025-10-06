import 'dart:ui';

import 'package:be_life_style/config/theme/app_colors.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingPlaceDetails extends StatelessWidget {
  const BookingPlaceDetails({super.key});

  @override
  Widget build(BuildContext context) {

    final imageSectionHeight = 375.h;
    final detailsSectionTop = imageSectionHeight - 56.h; // Adjust overlap as needed

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: imageSectionHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.bp0),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),


          Positioned(
            top: detailsSectionTop,
            left: 0,
            right: 0,
            bottom: 0, // Allow the container to expand to the bottom
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
                            child: Container(
                              height: 24.h,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                color: Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: Center(
                                child: Text(
                                  "Dining",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    color: Color(0xFF131313),
                                    fontSize: 12.sp,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
                            child: Container(
                              height: 24.h,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF788365),
                                    Color(0xFFA5A590),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: Center(
                                child: Text(
                                  "Confirmed",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    fontSize: 12.sp,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Dinner at Luxe Bistro",
                      style: TextStyle(
                        color: Color(0xFF202020),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.24,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFF696969),
                          size: 14.h,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "123 Nightlife Ave",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                            color: Color(0xFF696969),
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "Enjoy a luxurious dining experience at Luxe Bistro, known for its exquisite cuisine and elegant ambiance.",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14.sp,
                        color: Color(0xFF777777),
                        letterSpacing: -0.5,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      leading: SvgPicture.asset(
                        AppImages.callIcon,
                        height: 36.h,
                        width: 36.w,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        "Phone",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium!.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.black,
                          letterSpacing: -0.28,
                        ),
                      ),
                      subtitle: Text(
                        "+1 (201) 555-5555",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium!.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.greenColor,
                          letterSpacing: -0.28,
                        ),
                      ),
                    ),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      leading: Image.asset(
                        AppImages.rIcon,
                        height: 36.h,
                        width: 36.w,
                        fit: BoxFit.cover,
                      ),
                      title: Row(
                        children: [
                          Container(
                            height: 36.h,
                            width: 146.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Powered by Resy",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF202020),
                                  ),
                                ),
                                Icon(Icons.open_in_new_outlined, size: 17.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Itinerary details",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xFFF9F9F9)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Color(0xFFF6F6F6),
                                  child: Icon(
                                    Icons.access_time_outlined,
                                    color: AppColors.greenColor,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "Start time",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium!.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 112.w,
                                  child: Text(
                                    "Feb 21, 2025, 8:30 PM",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.greenColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 9.w),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xFFF9F9F9)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Color(0xFFF6F6F6),
                                  child: Icon(
                                    Icons.access_time_outlined,
                                    color: AppColors.greenColor,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "Start time",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium!.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 112.w,
                                  child: Text(
                                    "Feb 21, 2025, 8:30 PM",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.greenColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      leading: Image.asset(
                        AppImages.vineIcon,
                        height: 32.h,
                        width: 32.w,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        "Added service",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium!.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.black,
                          letterSpacing: -0.14,
                        ),
                      ),
                      subtitle: Text(
                        "Wine pairing included",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.greenColor,
                          letterSpacing: -0.24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
