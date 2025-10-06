import 'package:be_life_style/view_model/booking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/theme/app_colors.dart';
class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key, required this.text, required this.isChecked, required this.index});
final String text;
final int index;
final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,letterSpacing: -0.28),),
        Checkbox(activeColor: AppColors.black,
            side: BorderSide(color: Color(0xFFE8E8E8)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),),
            value: isChecked, onChanged: (val){
          context.read<BookingViewModel>().changeStatus(index);
            }),
      ],
    );
  }
}
