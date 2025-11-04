import 'package:ecomerc_app_with_admin/core/theme/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF3F51B5),
    textTheme: AppText.textTheme(),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xFF3F51B5),
    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: AppText.textTheme(),
    brightness: Brightness.dark,
  );
  static bool isdark(context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
