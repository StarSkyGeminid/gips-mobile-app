import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_pallete.dart';
import 'color_schemes.g.dart';

final kLightTheme = ThemeData(
  canvasColor: ColorPallete.light.bluishWhite,
  primaryColor: ColorPallete.light.primary,
  brightness: Brightness.light,
  focusColor: ColorPallete.light.primary,
  hintColor: ColorPallete.light.secondColor,
  colorScheme: lightColorScheme,
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.gaegu(
      fontSize: 30,
      fontWeight: FontWeight.w900,
      color: ColorPallete.light.primary,
    ),
    headlineMedium: GoogleFonts.gaegu(
      fontSize: 28,
      fontWeight: FontWeight.w900,
      color: ColorPallete.light.primary,
    ),
    headlineSmall: GoogleFonts.gaegu(
      fontSize: 26,
      fontWeight: FontWeight.w900,
      color: ColorPallete.light.primary,
    ),
    titleLarge: GoogleFonts.gaegu(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: ColorPallete.light.primary,
    ),
    titleMedium: GoogleFonts.gaegu(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: ColorPallete.light.primary,
    ),
    titleSmall: GoogleFonts.gaegu(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: ColorPallete.light.primary,
    ),
    bodyLarge: GoogleFonts.gaegu(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: ColorPallete.light.primary,
    ),
    bodyMedium: GoogleFonts.gaegu(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: ColorPallete.light.primary,
    ),
    bodySmall: GoogleFonts.gaegu(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorPallete.light.primary,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      textStyle: GoogleFonts.gaegu(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: ColorPallete.light.primary,
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
      foregroundColor: ColorPallete.light.black,
      backgroundColor: ColorPallete.light.yellow,
      side: BorderSide(
        color: ColorPallete.light.primary,
        width: 3,
      ),
      textStyle: GoogleFonts.gaegu(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: ColorPallete.light.primary,
      ),
    ),
  ),
  scaffoldBackgroundColor: lightColorScheme.background,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: lightColorScheme.background,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
    backgroundColor: lightColorScheme.background,
    foregroundColor: ColorPallete.light.primary,
    elevation: 0,
    toolbarHeight: 80,
    centerTitle: true,
    shadowColor: ColorPallete.light.grey.withOpacity(0.3),
    titleTextStyle: GoogleFonts.gaegu(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: ColorPallete.light.primary,
    ),
  ),
  iconTheme: IconThemeData(
    color: ColorPallete.light.primary,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(ColorPallete.light.primary),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: lightColorScheme.onPrimary,
    titleTextStyle: GoogleFonts.gaegu(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: ColorPallete.light.primary,
    ),
    contentTextStyle: GoogleFonts.gaegu(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorPallete.light.primary,
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      alignment: Alignment.center,
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
    ),
  ),
);
