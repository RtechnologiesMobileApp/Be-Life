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
    return ChangeNotifierProvider.value(
      value: getIt<ChatViewModel>(),
      child: Scaffold(
        appBar: AppBar(centerTitle: true,
        elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
          title: Text("Direct message",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700,color: Colors.black),),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w,),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSearchBar(),
              SizedBox(height:17.h ,),
              Consumer<ChatViewModel>(
                  builder: (context,cVM,_) {
                    return Expanded(
                      child:cVM.chatList.isEmpty?Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cVM.isLoading?CustomLoader():Text("You don't have any messages",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.black),),
                        ],
                      ): ListView.builder(
                        padding: EdgeInsets.zero,
                          itemCount: cVM.searchedChatList.isEmpty?cVM.chatList.length:cVM.searchedChatList.length,
                          itemBuilder: (context,index){
                            final chatItem=cVM.searchedChatList.isEmpty?cVM.chatList[index]:cVM.searchedChatList[index];
                            return Padding(
                              padding:  EdgeInsets.only(bottom: 20.h),
                              child: ChatCard(img: chatItem.profilePicture, name: chatItem.chatWithUsername, time: cVM.convertTime(chatItem.lastMessageTime,), subTitle: chatItem.lastMessage, unreadCount: chatItem.unreadCount, id: chatItem.chatWith,),
                            );
                          }),
                    );
                  }
              ),
              // SizedBox(height:20.h ,),
            ],),
        ),
      ),
    );
  }
}
