import 'package:be_life_style/view_model/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_images.dart';
class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({super.key, required this.receiverId});
final int receiverId;
  @override
  Widget build(BuildContext context) {
    return    Consumer<ChatViewModel>(
      builder: (context,chatVM,child) {
        return Row(
          children: [
            Expanded(
              child: Container(height: 46.h,decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(100),
              ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Center(child: TextField(
                  controller: chatVM.messageController,
                  cursorColor: Colors.black,
                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xFF131313).withValues(alpha: 0.5)),
                  decoration: InputDecoration(
                    hintText: "Write message...",
                    hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xFF131313).withValues(alpha: 0.24)),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),),
              ),
            ),
            SizedBox(width: 8.w,),
            InkWell(onTap: ()async{
              chatVM.sendMessage(receiverId);
            },child: SvgPicture.asset(AppImages.sendIcon))
          ],
        );
      }
    );
  }
}
