import 'package:flutter/material.dart';
import 'package:gips/core/theme/app_color.dart';

void showInfoSnackBar(
  BuildContext context,
  String text, {
  Color? backroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      backgroundColor: backroundColor ?? AppColor.black.withOpacity(0.8),
      content: Text(text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
