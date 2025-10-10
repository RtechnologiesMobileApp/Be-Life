
import 'package:be_life_style/view_model/auth/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
// import '../../config/routes/route_names.dart';
import '../../res/components/background.dart';
import '../../res/components/custom_app_bar.dart';
import '../../res/components/custom_btn.dart';
import '../../res/components/custom_linear_progress_bar.dart';

class CodeInputView extends StatelessWidget {
  const CodeInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final sVM = context.read<SignupViewModel>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
      ),
      body: Background(child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: kToolbarHeight + MediaQuery.of(context).padding.top),
            CustomLinearProgressBar(value: 0.2),
            SizedBox(height: 24.h,),
            Align(alignment:Alignment.topLeft,child: Text("5 digit code",style: Theme.of(context).textTheme.headlineMedium,)),
            SizedBox(height: 32.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Flexible(
                  child: Container(
                    width: 50,
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                     color: Colors.white.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                    cursorColor: Colors.white,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        counterText: '', // Hide counter
                        border: InputBorder.none,
                      ),
                      controller: sVM.otpControllers[index],
                      onChanged: (value){
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                );
              }),
            ), SizedBox(height: 24.h,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Having trouble? ',
                    style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white.withValues(alpha: 0.84),height: 1.4),
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: (){ sVM.resendOtp(context); },
                          child: Text('Resend now ', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600,height: 1.4)),
                        ),
                      ),
                    ],
                  ),
                ),
                Selector<SignupViewModel,String>(
                 selector: (_ ,sVM, )=>sVM.formattedTime,
                  builder: (_, timer, _) {
                   return   Text(timer,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),);
                  },
                ),
              ],
            ),
            SizedBox(height: 24.h,),
            Text("By entering, you agree to our Privacy policy & terms of conditions",style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.4,letterSpacing: 0.2)),
            const Spacer(),
            Selector<SignupViewModel,bool>(
              selector: (_, vm) => vm.isLoading,
              builder: (_, loading, __) {
                return CustomButton(
                  text: loading ? 'Verifying...' : 'Continue',
                  onPressed: () { if (!loading) sVM.confirmOtpAndProceed(context); },
                  color: Colors.white.withValues(alpha: 0.84,),
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,),
                );
              },
            ),
            SizedBox(height: 32.h),
          ],),)),
    );
  }
}
