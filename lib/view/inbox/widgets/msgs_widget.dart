import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../view_model/chat/chat_view_model.dart';
import 'package:flutter/material.dart';

class MsgsWidget extends StatefulWidget {
  const MsgsWidget({super.key, required this.currentChatId});
  final int currentChatId;

  @override
  State<MsgsWidget> createState() => _MsgsWidgetState();
}

class _MsgsWidgetState extends State<MsgsWidget> {
  bool _isOtherUserTyping = false;

  @override
  void initState() {
    super.initState();
    print(
      "🔵 CHAT_DEBUG [UI]: MsgsWidget initState for currentChatId: ${widget.currentChatId}",
    );
    final chatVM = Provider.of<ChatViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(
        "🔵 CHAT_DEBUG [UI]: MsgsWidget postFrameCallback - setting up scroll and typing",
      );
      chatVM.scrollToBottom();
      chatVM.attachScrollListener(widget.currentChatId);

      // Setup typing listeners
      chatVM.setupTypingListeners(
        (data) {
          print("🔵 CHAT_DEBUG: Typing event received: $data");
          if (data['fromUserId'] == widget.currentChatId) {
            setState(() {
              _isOtherUserTyping = true;
            });
            print("🔵 CHAT_DEBUG: Setting typing indicator to true");
          }
        },
        (data) {
          print("🔵 CHAT_DEBUG: Stop typing event received: $data");
          if (data['fromUserId'] == widget.currentChatId) {
            setState(() {
              _isOtherUserTyping = false;
            });
            print("🔵 CHAT_DEBUG: Setting typing indicator to false");
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);
    final currentUserProfilePic = profileVM.userDetails?.profilePicture;
    return Consumer<ChatViewModel>(
      builder: (context, chatVM, child) {
        print(
          "🔵 CHAT_DEBUG [UI]: MsgsWidget build - isLoading: ${chatVM.isLoading}, messages count: ${chatVM.messages.length}",
        );

        return chatVM.isLoading
            ? CustomLoader()
            : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: chatVM.scrollController,
                    padding: EdgeInsets.zero,
                    reverse: false,
                    itemCount: chatVM.messages.length,
                    itemBuilder: (context, index) {
                      final msg = chatVM.messages[index];
                      return Align(
                        alignment:
                            msg.senderId == SessionController().id
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical:
                                index + 1 >= chatVM.messages.length ||
                                        index + 1 < chatVM.messages.length &&
                                            chatVM
                                                    .messages[index + 1]
                                                    .senderId !=
                                                msg.senderId
                                    ? 0
                                    : 4.h,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                msg.senderId == SessionController().id
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,

                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 8.h,
                                      ),
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            299.w, // Ensures message box does not exceed 399 width
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            index > 0 &&
                                                    msg.senderId ==
                                                        chatVM
                                                            .messages[index - 1]
                                                            .senderId
                                                ? BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                  bottomLeft: Radius.circular(
                                                    16,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    4,
                                                  ),
                                                )
                                                : BorderRadius.circular(16),
                                        color:
                                            msg.senderId ==
                                                    SessionController().id
                                                ? Colors.white
                                                : Colors.white.withValues(
                                                  alpha: 0.12,
                                                ),
                                      ),
                                      child: Text(
                                        msg.content,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.copyWith(
                                          fontSize: 14.sp,
                                          color:
                                              msg.senderId ==
                                                      SessionController().id
                                                  ? Colors.black
                                                  : Colors.white,
                                          letterSpacing: -0.14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  if (chatVM.messages[index].receiverId !=
                                      SessionController().id)
                                    index + 1 >= chatVM.messages.length ||
                                            index + 1 <
                                                    chatVM.messages.length &&
                                                chatVM
                                                        .messages[index + 1]
                                                        .senderId !=
                                                    SessionController().id
                                        ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            28.r,
                                          ),
                                          child: Image.network(
                                            currentUserProfilePic ??
                                                AppImages.pp2, // fallback image
                                            fit: BoxFit.cover,
                                            width: 28.w,
                                            height: 28.h,
                                            errorBuilder:
                                                (_, __, ___) => Icon(
                                                  Icons.account_circle,
                                                  size: 28.w,
                                                  color: Colors.grey,
                                                ),
                                          ),
                                        )
                                        : SizedBox(width: 28.w, height: 28.h),
                                ],
                              ),

                              if (index + 1 >= chatVM.messages.length ||
                                  index + 1 < chatVM.messages.length &&
                                      chatVM.messages[index + 1].senderId !=
                                          msg.senderId)
                                SizedBox(height: 4.h),
                              if (index + 1 >= chatVM.messages.length ||
                                  index + 1 < chatVM.messages.length &&
                                      chatVM.messages[index + 1].senderId !=
                                          msg.senderId)
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 2.h,
                                    right:
                                        msg.senderId == SessionController().id
                                            ? 8.w
                                            : 0,
                                    left:
                                        msg.senderId == SessionController().id
                                            ? 0
                                            : 8.w,
                                  ),
                                  child: Text(
                                    DateFormat(
                                      'hh:mma',
                                    ).format(msg.createdAt ?? DateTime.now()),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.copyWith(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                              if (index + 1 >= chatVM.messages.length ||
                                  index + 1 < chatVM.messages.length &&
                                      chatVM.messages[index + 1].senderId !=
                                          msg.senderId)
                                SizedBox(height: 13.h),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Typing indicator
                if (_isOtherUserTyping)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "Typing...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
      },
    );
  }
}
