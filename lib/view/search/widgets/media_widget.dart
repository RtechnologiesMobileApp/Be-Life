import 'package:be_life_style/utils/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MediaWidget extends StatelessWidget {
  MediaWidget({super.key});
  final List<String>uploads=[
    AppImages.p1,
    AppImages.p2,
    AppImages.p3,
    AppImages.p4,
    AppImages.p5,
    AppImages.p1,
    AppImages.p1,
    AppImages.p2,
    AppImages.p3,
    AppImages.p4,
    AppImages.p5,
    AppImages.p1,
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: uploads.length,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 1, mainAxisExtent: 159.h,),
        itemBuilder: (context,index)=>Image.asset(uploads[index],fit: BoxFit.cover,height: 124.h,width: 159.w,));
  }
}
