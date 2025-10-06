import 'dart:io';
import 'package:be_life_style/view_model/videos/post_video_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../config/theme/app_colors.dart';
class CoverWidget extends StatelessWidget {
  const CoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<PostVideoViewModel>(
      builder: (context,pVM,_) {
        return pVM.pickedVideo==null?Container():ClipRRect(borderRadius: BorderRadius.circular(12.r),child: Stack(
          children: [
            pVM.customThumbnail==null?
            Image.memory(pVM.thumbnail!,height: 186.h,width: 127.w,fit: BoxFit.cover,):
            Image.file(File(pVM.customThumbnail!.path),height: 186.h,width: 127.w,fit: BoxFit.cover,),

            Positioned(
                right: 23.w,
                left: 23.w,
                bottom: 6.h,
                child: InkWell(
                  onTap: ()async{
                   await pVM.pickCoverFromGallery();
                  },
                  child: Container(height: 30.h,width: 81.w,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.r)
                    )
                    ,child: Center(child: Text("Edit cover",style: TextStyle(color: AppColors.black,fontSize: 14.sp,fontWeight: FontWeight.w500),),),),
                )),
          ],
        ));
      }
    );
  }
}
