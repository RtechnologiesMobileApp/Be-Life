import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1, -1), // Starts from top-left
          end: Alignment(1, 1),
            stops: [
              0.0, 0.08, 0.18, 0.28, 0.38, 0.48, 0.58, 0.68, 0.75, 0.82, 0.88, 0.94, 1.0
            ],
          colors: [
            Color(0xFFD7DADE),
            Color(0xFFD1D7DF),
            Color(0xFFB8CAE4),
            Color(0xFF9FBAE2),
            Color(0xFF7BA1D1),
            Color(0xFF6490C6),
            Color(0xFF5A88BD),
            Color(0xFF7291B2),
            Color(0xFF7B98B8),
            Color(0xFFA7BCCD),
            Color(0xFFC6D3D8),
            Color(0xFFBDC9CB),
            Color(0xFFCCD4CF),
          ],
        ),
      ),
      child: child, // Places content inside the background
    );
  }
}
