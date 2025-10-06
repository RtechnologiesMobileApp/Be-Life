
import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/config/routes/routes.dart';
import 'package:be_life_style/config/theme/theme.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/services/auth/auth_services.dart';
import 'package:be_life_style/services/cloudinary/cloudinary_services.dart';
import 'package:be_life_style/utils/image_picker_utils.dart';
import 'package:be_life_style/view_model/auth/signup_view_model.dart';
import 'package:be_life_style/view_model/videos/post_video_view_model.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'config/routes/route_names.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await ScreenUtil.ensureScreenSize();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context,child){
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
            lazy: true,
            create: (_)=>SignupViewModel(authServices: getIt<AuthServices>(),imagePickerUtils: getIt<ImagePickerUtils>()),
            ),
            ChangeNotifierProvider(
            lazy: true,
              create: (_)=>ProfileViewModel( userRepo: getIt<UserRepo>(),cloudinaryServices: getIt<CloudinaryServices>(),imagePickerUtils: getIt<ImagePickerUtils>()),
            ),
            ChangeNotifierProvider(
              create: (_)=>PostVideoViewModel(imagePickerUtils: getIt<ImagePickerUtils>(), videoRepo: getIt<VideoRepo>(), cloudinaryServices: getIt<CloudinaryServices>()),
              lazy: true,
            )
            ],
         child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            onGenerateRoute: Routes.generateRoute,
           initialRoute: RouteName.splashScreen,

          ),
        );
      },
    );
  }
}

