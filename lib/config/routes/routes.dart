import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/view/views.dart';
import 'package:be_life_style/view_model/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes{
 const Routes._();
 static Route<dynamic> generateRoute(RouteSettings settings){
   final args = settings.arguments as Map<String, dynamic>?;
   switch(settings.name){
     case RouteName.splashScreen:
       return MaterialPageRoute(builder: (context)=>const SplashView());
     case RouteName.welcomeScreen:
       return MaterialPageRoute(builder: (context)=>const WelcomeView());
     case RouteName.loginScreen:
       return MaterialPageRoute(builder: (context)=>const LoginView());
     case RouteName.nameInputScreen:
       return MaterialPageRoute(builder: (context)=> NameInputView());
     case RouteName.emailInputScreen:
       return MaterialPageRoute(builder: (context)=>const EmailInputView());
     case RouteName.dobInputScreen:
       return MaterialPageRoute(builder: (context)=>const DobInputView());
     case RouteName.noInputScreen:
       return MaterialPageRoute(builder: (context)=>const NoInputView());
     case RouteName.codeInputScreen:
       return MaterialPageRoute(builder: (context)=>const CodeInputView());
     case RouteName.passInputScreen:
       return MaterialPageRoute(builder: (context)=>const CreatePassView());
     case RouteName.interestsPickerScreen:
       return MaterialPageRoute(builder: (context)=>const InterestsPickerView());
     case RouteName.completeProfileScreen:
       return MaterialPageRoute(builder: (context)=>const CompleteProfileView());
     case RouteName.successScreen:
       return MaterialPageRoute(builder: (context)=>const SuccessView());
     case RouteName.mainNavScreen:
       return MaterialPageRoute(builder: (context)=>const MainNavScreen());
     case RouteName.directMsgScreen:
       return MaterialPageRoute(builder: (context)=>const DirectMsgView());
     case RouteName.settingsScreen:
       return MaterialPageRoute(builder: (context)=>const SettingsView());
     case RouteName.createPost:
       return MaterialPageRoute(builder: (context)=>const CreatePostView());
     case RouteName.chatScreen:
       final provider = args!['viewModel'] as ChatViewModel?;
       return MaterialPageRoute(
         builder: (context) => ChangeNotifierProvider.value(
           value: provider ?? getIt<ChatViewModel>(),
           child: ChatView(otherUserid: args['otherUserId'],name: args['name'], img: args['img']),
         ),
       );
     case RouteName.profileScreen:
       return MaterialPageRoute(builder: (context)=>const ProfileView());
     case RouteName.helpCenterScreen:
       return MaterialPageRoute(builder: (context)=>const HelpCenterView());
     case RouteName.editProfileScreen:
       return MaterialPageRoute(builder: (context)=>const EditProfileView());
     case RouteName.notificationsSettingsView:
       return MaterialPageRoute(builder: (context)=>const NotificationsSettingsView());
     case RouteName.privacySecurityView:
       return MaterialPageRoute(builder: (context)=>const PrivacySecurityView());
     case RouteName.searchScreen:
       return MaterialPageRoute(builder: (context)=>const SearchView());
     case RouteName.searchTabScreen:
       return MaterialPageRoute(builder: (context)=>const SearchTabView());
     case RouteName.placeInfoScreen:
       return MaterialPageRoute(builder: (context)=>const PlaceInfoView());
     case RouteName.bookingScreen:
       return MaterialPageRoute(builder: (context)=>const BookingsView());
     case RouteName.bookingPlaceDetails:
       return MaterialPageRoute(builder: (context)=>const BookingPlaceDetails());
     
     // New routes for missing features
     case RouteName.userSearchScreen:
       return MaterialPageRoute(builder: (context)=>const UserSearchView());
     case RouteName.otherUserProfileScreen:
       final userId = args!['userId'] as int;
       return MaterialPageRoute(builder: (context)=>OtherUserProfileView(userId: userId));
     case RouteName.followersScreen:
       final userId = args!['userId'] as int;
       final isFollowers = args['isFollowers'] as bool;
       return MaterialPageRoute(builder: (context)=>FollowersFollowingView(userId: userId, isFollowers: isFollowers));
     case RouteName.followingScreen:
       final userId = args!['userId'] as int;
       final isFollowers = args['isFollowers'] as bool;
       return MaterialPageRoute(builder: (context)=>FollowersFollowingView(userId: userId, isFollowers: isFollowers));

     default:
       return MaterialPageRoute(builder: (context)=>const Scaffold(body: Center(child: Text("No Route Defined"),),));
   }
 }
}