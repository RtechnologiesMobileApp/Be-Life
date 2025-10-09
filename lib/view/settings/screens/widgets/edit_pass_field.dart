import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EditPassField extends StatefulWidget {
  const EditPassField({super.key, required this.onSubmit, this.onChanged});
  final void Function(String newPassword) onSubmit;
  final void Function(String newPassword)? onChanged;

  @override
  State<EditPassField> createState() => _EditPassFieldState();
}

class _EditPassFieldState extends State<EditPassField> {
  final TextEditingController controller = TextEditingController();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          height: 56.h,
          width: 346.w,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
          child: Center(
            child: TextFormField(
              controller: controller,
              obscureText: _obscure,
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: Colors.white,
              onChanged: (val) {
                if (widget.onChanged != null) widget.onChanged!(val);
              },
              onFieldSubmitted: (val) {
                if (val.trim().isNotEmpty) widget.onSubmit(val.trim());
              },
              decoration: InputDecoration(
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     SizedBox(width: 8.w),
                    InkWell(
                      
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                        size: 18.h,
                      ),
                    ),
                   
                    // InkWell(
                    //   onTap: () {
                    //     final val = controller.text.trim();
                    //     if (val.isNotEmpty) widget.onSubmit(val);
                    //   },
                    //   child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 17.h),
                    // ),
                  ],
                ),
                hintText: 'New password',
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
