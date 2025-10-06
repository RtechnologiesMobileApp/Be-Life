import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SearchTopBar extends StatelessWidget {
  const SearchTopBar({super.key,this.isEnabled=true});
 final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        SizedBox(width: 11.w,),
        Flexible(
          child: Container(height: 52.h,
            width: 308.w,
            decoration: BoxDecoration(
              color: Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 16.w),
            child: Row(children: [
              Icon(CupertinoIcons.search,size: 20.h,),
              SizedBox(width: 6.w,),
              Expanded(
                child: TextField(

                  enabled: isEnabled,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF696969)),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                     hintText: isEnabled?"Search":"",
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF696969)),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(width: 6.w,),
              Icon(Icons.map_outlined,size: 20.h,color: Color(0xFF696969),),
            ],),
          ),
        ),
      ],
    );

  }
}
