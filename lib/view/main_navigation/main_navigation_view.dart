import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/view/bookings/bookings_view.dart';
import 'package:be_life_style/view/inbox/inbox_view.dart';
import 'package:be_life_style/view/main_navigation/widgets/bottom_nav.dart';
import 'package:be_life_style/view/post/create_post.dart';
import 'package:be_life_style/view/profile/profile_view.dart';
import 'package:be_life_style/view_model/main_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_view.dart';

class MainNavScreen extends StatelessWidget {
  const MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getIt<MainNavViewModel>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNav(),
        body: Consumer<MainNavViewModel>(
          builder: (context,pr,child) {
            return PageView(
              controller: pr.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeView(),
                InboxView(),
                CreatePostView() ,// Middle button
                BookingsView(),
                ProfileView(),
              ],
            );
          }
        ),
      ),
    );
  }
}
