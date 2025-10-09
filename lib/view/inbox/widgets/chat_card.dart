import 'package:be_life_style/config/routes/route_names.dart';
import 'package:be_life_style/view_model/chat/chat_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.img, required this.name, required this.time, required this.subTitle, required this.unreadCount, required this.id});
 final String img;
 final String name;
 final String time;
 final String subTitle;
 final int unreadCount;
 final int id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()async{
      print("🔵 CHAT_DEBUG [UI]: ChatCard tapped for chatId: $id, name: $name");
      Navigator.pushNamed(context, RouteName.chatScreen,
          arguments:{
        'otherUserId':id,
            'name': name,
            'img':img,
            "viewModel":context.read<ChatViewModel>(),
          } );
      print("🔵 CHAT_DEBUG [UI]: About to call fetchMessages for chatId: $id");
      await  context.read<ChatViewModel>().fetchMessages(id);
      print("🔵 CHAT_DEBUG [UI]: fetchMessages completed for chatId: $id");
      },
      minTileHeight: 0,
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(height: 46.h,width: 46.w,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
              child: CachedNetworkImage(imageUrl: img,fit: BoxFit.cover,)),

      ),
      title: Row( mainAxisSize: MainAxisSize.min,
        children: [
          Text(name,style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 14.sp,color: Colors.black),),
        SizedBox(width: 4.w,),
          Icon(Icons.circle,size: 6.h,color:  Color(0xFF797979)),
        SizedBox(width: 4.w,),
          Text(time,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xFF797979),fontSize: 12.sp),)
        ],
      ),
      subtitle: Text(subTitle,
          style:TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,  letterSpacing: -0.1,color: Color(0Xff131313),height: 1.2857),
      ),
      trailing:Row(mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle,size: 6.h,color:  unreadCount==0?Colors.white:Colors.red),
          SizedBox(width: 7.w,),
          Icon(Icons.arrow_forward_ios,color:Color(0xFFCCCCCC),size: 20.h,),
        ],
      ),   );
  }
}
