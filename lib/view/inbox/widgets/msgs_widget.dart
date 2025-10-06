import 'package:be_life_style/res/components/custom_loader.dart';
import 'package:be_life_style/services/session_manager/session_controller.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../view_model/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
class  MsgsWidget extends StatefulWidget {
  const  MsgsWidget({super.key, required this.currentChatId});
final int currentChatId;

  @override
  State<MsgsWidget> createState() => _MsgsWidgetState();
}

class _MsgsWidgetState extends State<MsgsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final chatVM=Provider.of<ChatViewModel>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatVM.scrollToBottom();
      chatVM.attachScrollListener(widget.currentChatId);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
        builder: (context,chatVM,child) {

          return chatVM.isLoading?CustomLoader():ListView.builder(
             controller: chatVM.scrollController,
              padding: EdgeInsets.zero,
              reverse: true,
              itemCount: chatVM.messages.length,
              itemBuilder: (context,index){
                final msg=chatVM.messages[index];
                return  Align(
                  alignment: msg.senderId == SessionController().id ? Alignment.centerRight : Alignment.centerLeft, child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w,
                      vertical:index + 1 >= chatVM.messages.length|| index + 1 < chatVM.messages.length && chatVM.messages[index + 1].senderId != msg.senderId?0:4.h),
                  child: Column(crossAxisAlignment: msg.senderId == SessionController().id ? CrossAxisAlignment.end : CrossAxisAlignment.start,

                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 8.h),
                              constraints: BoxConstraints(
                                maxWidth: 299.w, // Ensures message box does not exceed 399 width
                              ),
                              decoration: BoxDecoration(borderRadius: index > 0 && msg.senderId == chatVM.messages[index - 1].senderId?BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16),bottomLeft: Radius.circular(16),bottomRight: Radius.circular(4)):BorderRadius.circular(16),color: msg.senderId==SessionController().id?Colors.white:Colors.white.withValues(alpha: 0.12)),
                              child: Text(msg.content,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: msg.senderId==SessionController().id?Colors.black:Colors.white,letterSpacing: -0.14),),),
                          ),
                          SizedBox(width: 6.w,),
                          if (chatVM.messages[index].receiverId != SessionController().id) index + 1 >= chatVM.messages.length||index + 1 < chatVM.messages.length && chatVM.messages[index + 1].senderId != SessionController().id?Image.asset(AppImages.pp2,fit: BoxFit.cover,width: 28.w,height: 28.h,):SizedBox(width: 28.w,height: 28.h,)
                        ],
                      ),

                      if (index + 1 >= chatVM.messages.length||index + 1 < chatVM.messages.length && chatVM.messages[index + 1].senderId != msg.senderId)  SizedBox(height: 4.h,),
                      if (index + 1 >= chatVM.messages.length||index + 1 < chatVM.messages.length && chatVM.messages[index + 1].senderId != msg.senderId)Padding(
                        padding: EdgeInsets.only(top: 2.h, right: msg.senderId == SessionController().id ? 8.w : 0, left: msg.senderId == SessionController().id ? 0 : 8.w),
                        child: Text(
                DateFormat('hh:mma').format(msg.createdAt??DateTime.now()),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      if (index + 1 >= chatVM.messages.length||index + 1 < chatVM.messages.length && chatVM.messages[index + 1].senderId != msg.senderId) SizedBox(height: 13.h,)
                    ],
                  ),
                ),
                );
              });
        }
    );
  }
}