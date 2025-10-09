import 'package:be_life_style/config/locator.dart';
import 'package:be_life_style/config/theme/app_colors.dart';
import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/view/inbox/widgets/chat_card.dart';
import 'package:be_life_style/view/inbox/widgets/search_bar.dart';
import 'package:be_life_style/view_model/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DirectMsgView extends StatelessWidget {
  const DirectMsgView({super.key});

  @override
  Widget build(BuildContext context) {
    final chatVM = getIt<ChatViewModel>();

    return ChangeNotifierProvider.value(
      value: chatVM,
      child: const _DirectMsgContent(),
    );
  }
}

class _DirectMsgContent extends StatelessWidget {
  const _DirectMsgContent();

  @override
  Widget build(BuildContext context) {
    final cVM = context.watch<ChatViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          "Direct message",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.lightBlue,
        color: AppColors.black,
        onRefresh: () async => await cVM.fetchChatList(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomSearchBar(),
            ),
            SizedBox(height: 17.h),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    cVM.isLoading
                        ? const Center(child: CustomLoader())
                        : _buildChatList(context, cVM),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList(BuildContext context, ChatViewModel cVM) {
    final displayList =
        cVM.searchedChatList.isNotEmpty ? cVM.searchedChatList : cVM.chatList;

    if (displayList.isEmpty) {
      return Center(
        child: Text(
          "You don't have any messages",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: displayList.length,
      itemBuilder: (context, index) {
        final chatItem = displayList[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: ChatCard(
            img: chatItem.profilePicture,
            name: chatItem.chatWithUsername,
            time: cVM.convertTime(chatItem.lastMessageTime),
            subTitle: chatItem.lastMessage,
            unreadCount: chatItem.unreadCount,
            id: chatItem.chatWith,
          ),
        );
      },
    );
  }
}
