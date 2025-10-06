import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/model/user_model/user_search_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/view_model/user/user_search_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserSearchView extends StatelessWidget {
  const UserSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserSearchViewModel(userRepo: getIt<UserRepo>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search Users',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              _buildSearchBar(context),
              SizedBox(height: 24.h),
              Expanded(
                child: Consumer<UserSearchViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    
                    if (viewModel.searchResults.isEmpty && viewModel.searchQuery.isNotEmpty) {
                      return Center(
                        child: Text(
                          'No users found',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                    
                    if (viewModel.searchQuery.isEmpty) {
                      return Center(
                        child: Text(
                          'Search for users to connect with',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                    
                    return ListView.builder(
                      itemCount: viewModel.searchResults.length,
                      itemBuilder: (context, index) {
                        final user = viewModel.searchResults[index];
                        return _buildUserCard(context, user);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Consumer<UserSearchViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(100),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextField(
            onChanged: (value) {
              viewModel.setSearchQuery(value);
              if (value.isNotEmpty) {
                viewModel.searchUsers(value);
              }
            },
            controller: viewModel.searchController,
            cursorColor: Colors.black,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: Color(0xFF131313),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, size: 20.h),
              hintText: "Search users...",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: Color(0xFF131313).withValues(alpha: 0.5),
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserCard(BuildContext context, UserSearchModel user) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: CachedNetworkImage(
              imageUrl: user.profilePicture,
              height: 50.h,
              width: 50.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 50.h,
                width: 50.w,
                color: Colors.grey.shade300,
                child: Icon(Icons.person, color: Colors.grey.shade600),
              ),
              errorWidget: (context, url, error) => Container(
                height: 50.h,
                width: 50.w,
                color: Colors.grey.shade300,
                child: Icon(Icons.error, color: Colors.grey.shade600),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '@${user.username}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (user.isFollowing)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Following',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              else
                InkWell(
                  onTap: () {
                    // Navigate to other user profile
                    Navigator.pushNamed(
                      context,
                      RouteName.otherUserProfileScreen,
                      arguments: {'userId': user.id},
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'View Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () {
                  // Navigate to chat screen
                  Navigator.pushNamed(
                    context,
                    RouteName.chatScreen,
                    arguments: {
                      'otherUserId': user.id,
                      'name': '${user.firstName} ${user.lastName}',
                      'img': user.profilePicture,
                      'viewModel': null, // Will be created in chat screen
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 16.h,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
