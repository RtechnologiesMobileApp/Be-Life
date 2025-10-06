import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_model/auth/signup_view_model.dart';
import 'interest_card.dart';

class InterestGridView extends StatelessWidget {
  const InterestGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupViewModel>(
        builder: (context,pr,child) {
          return GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:context.read<SignupViewModel>().interests.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.h,
              ),
              itemBuilder: (context,index){
                var data= pr.interests[index];
                return  InterestCard(img:data.img , title: data.title, subTitle: data.subTitle, isSelected: data.isSelected, func: () { pr.selectInterest(index); },);});

        }
    );
  }
}
