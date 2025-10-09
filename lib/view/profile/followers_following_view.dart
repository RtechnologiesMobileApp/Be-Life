import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/model/user_model/other_user_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/view_model/user/followers_following_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FollowersFollowingView extends StatefulWidget {
  final int userId;
  final bool isFollowers;
  
  const FollowersFollowingView({
    super.key, 
    required this.userId, 
    required this.isFollowers,
  });

  @override
  State<FollowersFollowingView> createState() => _FollowersFollowingViewState();
}

class _FollowersFollowingViewState extends State<FollowersFollowingView> {
  @override
  void initState() {
    super.initState();
    // Remove the context.read call from initState
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FollowersFollowingViewModel(userRepo: getIt<UserRepo>()),
      child: _FollowersFollowingContent(
        userId: widget.userId,
        isFollowers: widget.isFollowers,
      ),
    );
  }
}

class _FollowersFollowingContent extends StatefulWidget {
  final int userId;
  final bool isFollowers;
  
  const _FollowersFollowingContent({
    required this.userId, 
    required this.isFollowers,
  });

  @override
  State<_FollowersFollowingContent> createState() => _FollowersFollowingContentState();
}

class _FollowersFollowingContentState extends State<_FollowersFollowingContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<FollowersFollowingViewModel>();
      if (widget.isFollowers) {
        viewModel.getFollowers(widget.userId);
      } else {
        viewModel.getFollowing(widget.userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isFollowers ? 'Followers' : 'Following',
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
        child: Consumer<FollowersFollowingViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            final users = widget.isFollowers ? viewModel.followers : viewModel.following;
            
            if (users.isEmpty) {
              return Center(
                child: Text(
                  widget.isFollowers 
                      ? 'No followers yet' 
                      : 'Not following anyone yet',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return _buildUserCard(context, viewModel, user);
              },
            );
          },
        ),
      ),
    );
  }

Widget _buildUserCard(
  BuildContext context,
  FollowersFollowingViewModel viewModel,
  OtherUserModel user,
) {
  //final currentUserId = getIt<UserRepo>().currentUser?.id; // 👈 add this line

final currentUserId = SessionController().id;

  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteName.otherUserProfileScreen,
              arguments: {'userId': user.id},
            );
          },
          child: ClipRRect(
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
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteName.otherUserProfileScreen,
                arguments: {'userId': user.id},
              );
            },
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
        ),
        if (user.id != currentUserId) // 👈 only show buttons for *other* users
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 36.h,
                child: ElevatedButton(
                  onPressed: viewModel.isFollowLoading
                      ? null
                      : () {
                          if (user.isFollowing) {
                            viewModel.unfollowUser(user.id);
                          } else {
                            viewModel.followUser(user.id);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: user.isFollowing
                        ? Colors.grey.shade300
                        : Colors.blue,
                    foregroundColor: user.isFollowing
                        ? Colors.grey.shade700
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  child: viewModel.isFollowLoading
                      ? SizedBox(
                          height: 16.h,
                          width: 16.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              user.isFollowing
                                  ? Colors.grey.shade700
                                  : Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          user.isFollowing ? 'Unfollow' : 'Follow',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
            ],
          ),
      ],
    ),
  );
}

  // Widget _buildUserCard(
  //   BuildContext context, 
  //   FollowersFollowingViewModel viewModel, 
  //   OtherUserModel user
  // ) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 12.h),
  //     padding: EdgeInsets.all(16.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.grey.shade200),
  //     ),
  //     child: Row(
  //       children: [
  //         InkWell(
  //           onTap: () {
  //             Navigator.pushNamed(
  //               context,
  //               RouteName.otherUserProfileScreen,
  //               arguments: {'userId': user.id},
  //             );
  //           },
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(25.r),
  //             child: CachedNetworkImage(
  //               imageUrl: user.profilePicture,
  //               height: 50.h,
  //               width: 50.w,
  //               fit: BoxFit.cover,
  //               placeholder: (context, url) => Container(
  //                 height: 50.h,
  //                 width: 50.w,
  //                 color: Colors.grey.shade300,
  //                 child: Icon(Icons.person, color: Colors.grey.shade600),
  //               ),
  //               errorWidget: (context, url, error) => Container(
  //                 height: 50.h,
  //                 width: 50.w,
  //                 color: Colors.grey.shade300,
  //                 child: Icon(Icons.error, color: Colors.grey.shade600),
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 16.w),
  //         Expanded(
  //           child: InkWell(
  //             onTap: () {
  //               Navigator.pushNamed(
  //                 context,
  //                 RouteName.otherUserProfileScreen,
  //                 arguments: {'userId': user.id},
  //               );
  //             },
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   '${user.firstName} ${user.lastName}',
  //                   style: Theme.of(context).textTheme.headlineMedium!.copyWith(
  //                     color: Colors.black,
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 SizedBox(height: 4.h),
  //                 Text(
  //                   '@${user.username}',
  //                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
  //                     color: Colors.grey.shade600,
  //                     fontSize: 14.sp,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             // Follow/Unfollow Button
  //             Container(
  //               height: 36.h,
  //               child: ElevatedButton(
  //                 onPressed: viewModel.isFollowLoading
  //                     ? null
  //                     : () {
  //                         if (user.isFollowing) {
  //                           viewModel.unfollowUser(user.id);
  //                         } else {
  //                           viewModel.followUser(user.id);
  //                         }
  //                       },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: user.isFollowing ? Colors.grey.shade300 : Colors.blue,
  //                   foregroundColor: user.isFollowing ? Colors.grey.shade700 : Colors.white,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(18.r),
  //                   ),
  //                   padding: EdgeInsets.symmetric(horizontal: 16.w),
  //                 ),
  //                 child: viewModel.isFollowLoading
  //                     ? SizedBox(
  //                         height: 16.h,
  //                         width: 16.w,
  //                         child: CircularProgressIndicator(
  //                           strokeWidth: 2,
  //                           valueColor: AlwaysStoppedAnimation<Color>(
  //                             user.isFollowing ? Colors.grey.shade700 : Colors.white,
  //                           ),
  //                         ),
  //                       )
  //                     : Text(
  //                         user.isFollowing ? 'Unfollow' : 'Follow',
  //                         style: TextStyle(
  //                           fontSize: 14.sp,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //               ),
  //             ),
  //             SizedBox(width: 8.w),
  //             // Message Button
              
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }


}
