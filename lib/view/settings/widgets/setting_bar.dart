import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingBar extends StatelessWidget {
  const SettingBar({super.key, required this.text, required this.img,this.color=const Color(0xFF202020), required this.func});
final String text;
final String img;
final Color color;
final VoidCallback func;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: func ,
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        leading: SizedBox(height: 24.h,width: 24.w,
          child: SvgPicture.asset(img,fit: BoxFit.cover,),),
        title: Text(text,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color:color ),),
        trailing: Icon(Icons.arrow_forward_ios,size: 15.h,color: Color(0xff000000),)
    );
  }
}
