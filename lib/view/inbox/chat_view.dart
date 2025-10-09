import 'package:be_life_style/view/inbox/widgets/msgs_widget.dart';
import 'package:be_life_style/view/inbox/widgets/send_message_widget.dart';
import 'package:be_life_style/view_model/chat/chat_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../res/components/background.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    super.key,
    required this.name,
    required this.img,
    required this.otherUserid,
  });
  final String name;
  final String img;
  final int otherUserid;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    print(
      "🔵 CHAT_DEBUG [UI]: ChatView initState for otherUserid: ${widget.otherUserid}",
    );
    WidgetsBinding.instance.addObserver(this);

    // Mark messages as read when chat opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("🔵 CHAT_DEBUG [UI]: ChatView postFrameCallback - marking as read");
      final chatVM = Provider.of<ChatViewModel>(context, listen: false);
      chatVM.markAsRead(widget.otherUserid);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Mark messages as read when app comes back to foreground
      final chatVM = Provider.of<ChatViewModel>(context, listen: false);
      chatVM.markAsRead(widget.otherUserid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white.withValues(alpha: 0.83),
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: CachedNetworkImage(
              imageUrl: widget.img,
              height: 42.h,
              width: 42.h,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            widget.name,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Consumer<ChatViewModel>(
        builder: (context, cVM, _) {
          return Background(
            child: Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 4.w,
                bottom: 31.h,
                top: 10.h,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MsgsWidget(currentChatId: widget.otherUserid),
                  ),

                  Column(
                    children: [
                      Divider(color: Colors.white.withValues(alpha: 0.12)),
                      SizedBox(height: 10.h),
                      SendMessageWidget(receiverId: widget.otherUserid),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
