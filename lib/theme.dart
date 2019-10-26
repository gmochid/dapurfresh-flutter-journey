import 'package:flutter/material.dart';

class ThemeColor {
  static final primary = Color(0xFF6AA434);
  static final secondary = Color(0xFF547F1E);
  static final primaryVariant = Color(0xFFA9CF46);
  static final grey = Color(0xFF888888);
  static final lightGrey = Colors.black12;
  static final backgroundGrey = Color(0xFFF4F4F4);
  static final black = Color(0xFF444444);

  static final ColorScheme scheme = ColorScheme(
    primary: ThemeColor.primary,
    secondary: ThemeColor.secondary,
    primaryVariant: ThemeColor.primaryVariant,
    secondaryVariant: ThemeColor.secondary,
    error: Colors.red,
    surface: Colors.black,
    brightness: Brightness.light,
    background: ThemeColor.lightGrey,
    onPrimary: ThemeColor.primary,
    onSecondary: ThemeColor.secondary,
    onError: Colors.red,
    onBackground: ThemeColor.lightGrey,
    onSurface: Colors.black,
  );
}
