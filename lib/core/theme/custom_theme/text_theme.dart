import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  AppText._();
  static TextTheme textTheme() => GoogleFonts.poppinsTextTheme().copyWith(
    titleLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w900),
    titleMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
    titleSmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
    labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
    labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w200),
  );
}
