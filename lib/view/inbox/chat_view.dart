
import 'package:be_life_style/view/inbox/widgets/msgs_widget.dart';
import 'package:be_life_style/view/inbox/widgets/send_message_widget.dart';
import 'package:be_life_style/view_model/chat/chat_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../res/components/background.dart';
class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.name, required this.img, required this.otherUserid});
final String name;
final String img;
final int otherUserid;
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
            borderRadius: BorderRadius.circular(50.r)
          ,child: CachedNetworkImage(imageUrl: img,height: 42.h,width: 42.h,fit: BoxFit.cover,)),
          title: Text(name,style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 18.sp,color: Colors.black),),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Consumer<ChatViewModel>(
        builder: (context,cVM,_) {
          return Background(child: Container(
            padding: EdgeInsets.only(left: 16.w,right:16.w,bottom: 31.h,top: 10.h),
            height: double.infinity,
            width: double.infinity,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Expanded(child: MsgsWidget(currentChatId: otherUserid,)),

          Column(
            children: [
              Divider(color: Colors.white.withValues(alpha: 0.12),),
              SizedBox(height: 10.h,),
           SendMessageWidget(receiverId: otherUserid,),
            ],
          )
            ],),
          ));
        }
      ),
    );
  }
}
