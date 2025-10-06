import 'package:be_life_style/model/video_model/video_model.dart';
import 'package:be_life_style/view/home/screens/widgets/comment_bottom_sheet.dart';
import 'package:be_life_style/view/home/screens/widgets/share_bottom_sheet.dart';
import 'package:be_life_style/view_model/videos/for_you_view_model.dart';
import 'package:be_life_style/config/routes/route_names.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_images.dart';
import 'package:be_life_style/view_model/profile/profile_view_model.dart';

class RightBar extends StatelessWidget {
  const RightBar({super.key,required this.videoData});
final VideoModel videoData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 14.0.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  InkWell(
                                         onTap: () {
                       // Navigate to the uploader's profile
                       if (videoData.postedBy != null) {
                         // Pause all videos before navigation
                         try {
                           final videosVM = context.read<VideosViewModel>();
                           videosVM.pauseAllVideos();
                         } catch (e) {
                           // VideosViewModel might not be available in this context
                         }
                         
                         Navigator.pushNamed(
                           context,
                           RouteName.otherUserProfileScreen,
                           arguments: {'userId': videoData.postedBy!},
                         );
                       }
                     },
                    child: Container(
                      height: 48.w,
                      width: 48.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: CachedNetworkImage(
                          imageUrl:videoData.uploaderProfilePicture!, // <-- replace with actual image URL
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Positioned(bottom: -7.84.h,left: 0,right: 0,
                      child: SizedBox(height: 24.h,width: 24.w,child: CircleAvatar(backgroundColor: Colors.black,child: Icon(Icons.add,color: Colors.white,size: 18.h,))))
                ],
              ),
              SizedBox(height: 22.h,),
              Consumer<VideosViewModel>(
                builder: (context,vVM,_) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: ()async{
                          await vVM.toggleLike(videoData.id!);
                          // Refresh profile data to update likes count
                          try {
                            final profileVM = context.read<ProfileViewModel>();
                            profileVM.refreshUserDetails();
                          } catch (e) {
                            // ProfileViewModel might not be available in this context
                          }
                        },
                          child: SizedBox(height: 32.h,width: 32.h,child: SvgPicture.asset(videoData.isLiked==true?AppImages.heartFillIcon:AppImages.heartIcon,fit: BoxFit.cover,),)),
                      SizedBox(height: 3.h,),
                      Text(videoData.likesCount.toString(),style: Theme.of(context).textTheme.bodyMedium,)
                    ],
                  );
                }
              ),
              SizedBox(height: 22.h,),
              Column(
                children: [
                  SizedBox(height: 32.h,width: 32.h,child: InkWell(onTap: (){
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      backgroundColor: Colors.white.withValues(alpha: 0.98),
                        context: context, builder: (context)=>CommentBottomSheet(id: videoData.id!,));
                  },child: SvgPicture.asset(AppImages.chatIcon,fit: BoxFit.cover,)),),
                  SizedBox(height: 3.h,),
                  Text(videoData.commentsCount.toString(),style: Theme.of(context).textTheme.bodyMedium,)
                ],
              ),
              SizedBox(height: 22.h,),
              Column(
                children: [
                  InkWell(onTap: (){
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        backgroundColor: Colors.white.withValues(alpha: 0.98),
                        context: context, builder: (context)=>const ShareBottomSheet());
                  },child: SizedBox(height: 32.h,width: 32.h,child: SvgPicture.asset(AppImages.shareIcon,fit: BoxFit.cover,),)),
                  SizedBox(height: 3.h,),
                  Text(videoData.shareCount.toString(),style: Theme.of(context).textTheme.bodyMedium,)
                ],
              ),
              SizedBox(height: 22.h,),
              Consumer<VideosViewModel>(
                builder: (context,vVM,_) {
                  return InkWell(
                      onTap: ()async{
                       await vVM.toggleBookmark(videoData.id!);
                        },
                      child: SizedBox(height: 32.h,width: 32.h,child: SvgPicture.asset(videoData.isSaved==true?AppImages.bookmarkFillIcon:AppImages.bookmarkIcon,fit: BoxFit.cover,),));
                }
              ), SizedBox(height: 24.h,),


            ],
          ),

          Container(
            height: 38.h,
            width: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(37),
              color: Colors.white.withValues(alpha: 0.08),
              border: Border.all(width: 1.5,color: Colors.white),
            ),
            child: Center(child: Text("Book now",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),),),
          ),
          SizedBox(height: 8.h,)
        ],
      ),
    );
  }
}
