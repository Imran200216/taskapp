import 'package:flutter/material.dart';
import 'package:taskapp/core/styles/app_text_styles.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    // Scaffold background color
    scaffoldBackgroundColor: ColorName.white,

    // Color scheme
    colorScheme: ColorScheme.fromSeed(seedColor: ColorName.primary),

    // Font family
    fontFamily: FontFamily.poppins,

    // Text theme
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.headlineTextLarge,
      headlineMedium: AppTextStyles.headlineTextMedium,
      bodyLarge: AppTextStyles.bodyTextLarge,
      bodyMedium: AppTextStyles.bodyTextMedium,
      bodySmall: AppTextStyles.bodyTextSmall,
    ),
  );
}
