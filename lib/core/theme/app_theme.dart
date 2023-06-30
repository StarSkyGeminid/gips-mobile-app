import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/theme/app_color.dart';

import 'app_textsyle.dart';

class AppTheme {
  static final AppTextStyle _textStyle = AppTextStyle.instance;

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.purple,
    primarySwatch: AppColor.primarySwatch,
    textTheme: TextTheme(
      displayLarge: _textStyle.displayLarge,
      displayMedium: _textStyle.displayMedium,
      displaySmall: _textStyle.displaySmall,
      headlineLarge: _textStyle.headlineLarge,
      headlineMedium: _textStyle.headlineMedium,
      headlineSmall: _textStyle.headlineSmall,
      titleLarge: _textStyle.titleLarge,
      titleSmall: _textStyle.titleSmall,
      titleMedium: _textStyle.titleMedium,
      labelLarge: _textStyle.labelLarge,
      labelMedium: _textStyle.labelMedium,
      labelSmall: _textStyle.labelSmall,
      bodyLarge: _textStyle.bodyLarge,
      bodyMedium: _textStyle.bodyMedium,
      bodySmall: _textStyle.bodySmall,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        textStyle: GoogleFonts.gaegu(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColor.primaryColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        foregroundColor: AppColor.primaryColor,
        backgroundColor: AppColor.yellow,
        side: const BorderSide(
          color: AppColor.primaryColor,
          width: 3,
        ),
        textStyle: GoogleFonts.gaegu(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColor.primaryColor,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: AppColor.purple,
      foregroundColor: AppColor.primaryColor,
      elevation: 0,
      toolbarHeight: 80,
      centerTitle: true,
      shadowColor: AppColor.grey.withOpacity(0.3),
      titleTextStyle: GoogleFonts.gaegu(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppColor.primaryColor,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColor.primaryColor,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(AppColor.primaryColor),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColor.white,
      titleTextStyle: GoogleFonts.gaegu(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppColor.primaryColor,
      ),
      contentTextStyle: GoogleFonts.gaegu(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColor.primaryColor,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
      hintStyle: GoogleFonts.gaegu(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColor.primaryColor,
      ),
      iconColor: AppColor.primaryColor,
      focusColor: AppColor.white,
      fillColor: AppColor.white,
      filled: true,
      prefixIconColor: AppColor.black,
      suffixIconColor: AppColor.black,
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.primaryColor, width: 2)),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.primaryColor, width: 2)),
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.red, width: 1)),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.red, width: 2)),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.backgroundBlack,
    primaryColor: AppColor.primaryColor,
    primarySwatch: AppColor.primarySwatch,
    textTheme: TextTheme(
      displayLarge: _textStyle.displayLarge.copyWith(color: AppColor.white),
      displayMedium: _textStyle.displayMedium.copyWith(color: AppColor.white),
      displaySmall: _textStyle.displaySmall.copyWith(color: AppColor.white),
      headlineLarge: _textStyle.headlineLarge.copyWith(color: AppColor.white),
      headlineMedium: _textStyle.headlineMedium.copyWith(color: AppColor.white),
      headlineSmall: _textStyle.headlineSmall.copyWith(color: AppColor.white),
      titleLarge: _textStyle.titleLarge.copyWith(color: AppColor.white),
      titleSmall: _textStyle.titleSmall.copyWith(color: AppColor.white),
      titleMedium: _textStyle.titleMedium.copyWith(color: AppColor.white),
      labelLarge: _textStyle.labelLarge.copyWith(color: AppColor.white),
      labelMedium: _textStyle.labelMedium.copyWith(color: AppColor.white),
      labelSmall: _textStyle.labelSmall.copyWith(color: AppColor.white),
      bodyLarge: _textStyle.bodyLarge.copyWith(color: AppColor.white),
      bodyMedium: _textStyle.bodyMedium.copyWith(color: AppColor.white),
      bodySmall: _textStyle.bodySmall.copyWith(color: AppColor.white),
    ),
  );
}
