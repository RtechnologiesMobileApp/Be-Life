import 'package:flutter/material.dart';

class CustomLinearProgressBar extends StatelessWidget {
  final double value;
  const CustomLinearProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height:2,child: LinearProgressIndicator(color: Colors.white,value:value,));

  }
}
