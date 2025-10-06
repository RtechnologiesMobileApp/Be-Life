import 'package:be_life_style/config/theme/app_colors.dart';
import 'package:be_life_style/utils/app_images.dart';
import 'package:be_life_style/view/settings/screens/widgets/custom_accordian.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
class HelpCenterView extends StatefulWidget {
  const HelpCenterView({super.key});

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> {
  final ExpansionTileController _controller = ExpansionTileController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.expand(); // Open by default
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text("Help center",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700,color: Colors.black),),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 24.h),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImages.helpIcon,height: 76.h,width: 141.w,fit: BoxFit.cover,),
              SizedBox(height: 16.h,),
          Text("We’re Here to Help",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.black),),
              SizedBox(height: 12.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Text("Got questions or need assistance? Reach out to us—we’d love to hear from you.",style: Theme.of(context).textTheme.bodyLarge!.copyWith( letterSpacing: -0.5,
                height: 20 / 16, color: AppColors.black.withValues(alpha: 0.60)),textAlign: TextAlign.center,),
          ),
           SizedBox(height: 32.h,),
              Container(height: 56.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Send us a message",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.black),),
                SvgPicture.asset(AppImages.openIcon,height: 24.h,width: 24.w,fit: BoxFit.cover,)

              ],
            ),
          ),
              SizedBox(height: 8.h,),
              Container(height: 56.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Report a problem",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.black),),
                    SvgPicture.asset(AppImages.openIcon,height: 24.h,width: 24.w,fit: BoxFit.cover,)
                  ],
                ),
              ),
              SizedBox(height: 26.h,),
              Align(alignment:Alignment.topLeft,child: Text("FAQs",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF131313)),)),
              SizedBox(height: 17.h,),

              CustomAccordion(title: "What is Be?", subTitle: "You can simply go to the bookings tab to view the different bookings available in your feed.",
                ),
              CustomAccordion(title: "How can I add a business to Be?", subTitle: "You can simply go to the bookings tab to view the different bookings available in your feed.",
                 controller: _controller,),
              CustomAccordion(title: "How do I create an account?", subTitle: "You can simply go to the bookings tab to view the different bookings available in your feed.",
                 ),
              CustomAccordion(title: "How do make a booking?", subTitle: "You can simply go to the bookings tab to view the different bookings available in your feed.",
                 ),
            ],),
        ),
      ),
    );
  }
}
