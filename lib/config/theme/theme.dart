import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
        dragHandleColor: Color(0xffD1D4D7)
    ),
    fontFamily: 'ProximaNova',
    //primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme:  TextTheme(
      headlineLarge: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.w700,color: Colors.white),
      headlineMedium: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.w700,color: Colors.white),
      headlineSmall: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w700,color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400,color: Colors.white),
      bodyMedium: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400,color: Colors.white),
      ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'FontName',
  //  primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white70),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white60),
    ),
  );
}
