import 'package:flutter/material.dart';
import 'package:music_app/themes/color.dart';

class Themes {
  static final lightTheme = ThemeData(
    primaryColor: AppColor.white,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        background: Colors.white,
        secondary: Colors.white,
        primary: Colors.white),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColor.black,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        secondary: Colors.grey[800]!,
        primary: Colors.grey[900]!),
  );
}
