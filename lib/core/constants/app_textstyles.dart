import 'package:flutter/material.dart';
import 'package:tornet_assignment/core/constants/app_colors.dart';

class AppTextstyles {
  AppTextstyles._();

   static const TextStyle headlineH6 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: 0,
    color: AppColors.black,
  );
   static const TextStyle headlineH5 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w700,
    fontSize: 28,
    letterSpacing: 0,
    color: AppColors.white,
  );
   static const TextStyle content14 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0,
    color: AppColors.gray,
  );
   static const TextStyle content12 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0,
    color: AppColors.white,
  );
   static const TextStyle placeholder16 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0,
    color: AppColors.placeholder,
  );
   static const TextStyle button12 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w700,
    fontSize: 12,
    letterSpacing: 0,
    color: AppColors.buttonText,
  );
   static const TextStyle button16 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 0,
    color: AppColors.buttonText,
  );
   static const TextStyle title12 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w700,
    fontSize: 12,
    letterSpacing: 0,
    color: AppColors.white,
  );
   static const TextStyle title18 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: 0,
    color: AppColors.white,
  );
   static  TextStyle textLink = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0,
    color: AppColors.contentDark,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.contentDark,
    decorationStyle: TextDecorationStyle.solid
  );

    static TextStyle title20 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w700, 
    fontSize: 20,
    height: 28 / 20, 
    letterSpacing: 0, 
    foreground: Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF86F14D),
          Color(0xFFE6FF48),
        ],
      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)), 
  );
    static TextStyle title14 = TextStyle(
    fontFamily: 'ChakraPetch',
    fontWeight: FontWeight.w700, 
    fontSize: 14,
    letterSpacing: 0, 
    foreground: Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF86F14D),
          Color(0xFFE6FF48),
        ],
      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
  );
}
