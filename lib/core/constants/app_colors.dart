import 'package:flutter/material.dart';

class AppColors {
  static const Color mainBackground = Color(0xff1e2224);
  static const Color placeholder = Color(0xff949699);
  static const Color inputBackground = Color(0xff2E3236);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color gray = Color(0xff545852);
  static const Color focusedBorder = Color(0xFF4A4A4A);
  static const Color buttonText = Color(0xff212735);
  static const Color buttonSolid = Color(0xffAAFF01);
  static const Color buttonSecond = Color(0xff2E3236);
  static const Color backgroundSP1 = Color(0xff2E3236);
  static const Color backgroundSP2 = Color(0xff43484C);
  static  Color contentDark = const Color(0xffffffff).withValues(alpha: 0.8);
   // Solid colors
  static const Color greenStart = Color(0xFF86F14D);
  static const Color greenEnd = Color(0xFFE6FF48);

  // Linear Gradient for button
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      greenStart,
      greenEnd,
    ],
  );
}