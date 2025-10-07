import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/model/user_model/other_user_model.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagPeopleBottomSheet extends StatefulWidget {
  final List<OtherUserModel> taggedUsers;
  final Function(List<OtherUserModel>) onTaggedUsersChanged;

  const TagPeopleBottomSheet({
    super.key,
    required this.taggedUsers,
    required this.onTaggedUsersChanged,
  });

  @override
  State<TagPeopleBottomSheet> createState() => _TagPeopleBottomSheetState();
}

class _TagPeopleBottomSheetState extends State<TagPeopleBottomSheet> {
  final List<OtherUserModel> _allUsers = [];
  final List<OtherUserModel> _filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  late List<OtherUserModel> _localTaggedUsers;

  @override
  void initState() {
    super.initState();
    _localTaggedUsers = List.from(widget.taggedUsers);
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userRepo = getIt<UserRepo>();
      final token = SessionController().token;
      final currentUserId = SessionController().id!;

      // Get both followers and following
      final followers = await userRepo.getFollowers(currentUserId, token);
      final following = await userRepo.getFollowing(currentUserId, token);

      // Combine and remove duplicates
      final Set<int> userIds = {};
      final List<OtherUserModel> combinedUsers = [];

      // Add followers
      for (final user in followers) {
        if (!userIds.contains(user.id)) {
          userIds.add(user.id);
          combinedUsers.add(user);
        }
      }

      // Add following (avoid duplicates)
      for (final user in following) {
        if (!userIds.contains(user.id)) {
          userIds.add(user.id);
          combinedUsers.add(user);
        }
      }

      setState(() {
        _allUsers.clear();
        _allUsers.addAll(combinedUsers);
        _filteredUsers.clear();
        _filteredUsers.addAll(combinedUsers);
      });
    } catch (e) {
      debugPrint('Error loading users: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterUsers(String query) {
    setState(() {
      _filteredUsers.clear();
      if (query.isEmpty) {
        _filteredUsers.addAll(_allUsers);
      } else {
        _filteredUsers.addAll(
          _allUsers.where((user) =>
              user.firstName.toLowerCase().contains(query.toLowerCase()) ||
              user.lastName.toLowerCase().contains(query.toLowerCase()) ||
              user.username.toLowerCase().contains(query.toLowerCase())),
        );
      }
    });
  }

  void _toggleUserSelection(OtherUserModel user) {
    setState(() {
      if (_localTaggedUsers.any((tagged) => tagged.id == user.id)) {
        // Remove from tagged users
        _localTaggedUsers.removeWhere((tagged) => tagged.id == user.id);
        debugPrint('Removed user: ${user.firstName} ${user.lastName}');
      } else {
        // Add to tagged users
        _localTaggedUsers.add(user);
        debugPrint('Added user: ${user.firstName} ${user.lastName}');
      }
    });
    widget.onTaggedUsersChanged(_localTaggedUsers);
    debugPrint('Total tagged users: ${_localTaggedUsers.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            height: 4.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          
          // Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Text(
                  'Tag People',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextField(
              controller: _searchController,
              onChanged: _filterUsers,
              decoration: InputDecoration(
                hintText: 'Search people...',
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Selected users (if any)
          if (_localTaggedUsers.isNotEmpty)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected (${_localTaggedUsers.length})',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children: _localTaggedUsers.map((user) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${user.firstName} ${user.lastName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            GestureDetector(
                              onTap: () => _toggleUserSelection(user),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 14.h,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

          SizedBox(height: 16.h),

          // Users list
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredUsers.isEmpty
                    ? Center(
                        child: Text(
                          'No people found',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16.sp,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: _filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = _filteredUsers[index];
                          final isSelected = _localTaggedUsers.any((tagged) => tagged.id == user.id);

                          return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: CachedNetworkImage(
                                  imageUrl: user.profilePicture,
                                  height: 40.h,
                                  width: 40.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    height: 40.h,
                                    width: 40.w,
                                    color: Colors.grey.shade300,
                                    child: Icon(Icons.person, color: Colors.grey.shade600),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    height: 40.h,
                                    width: 40.w,
                                    color: Colors.grey.shade300,
                                    child: Icon(Icons.error, color: Colors.grey.shade600),
                                  ),
                                ),
                              ),
                              title: Text(
                                '${user.firstName} ${user.lastName}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                '@${user.username}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              trailing: Checkbox(
                                value: isSelected,
                                onChanged: (_) => _toggleUserSelection(user),
                                activeColor: Colors.blue,
                              ),
                              onTap: () => _toggleUserSelection(user),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
