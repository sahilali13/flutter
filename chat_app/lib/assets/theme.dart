import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    primarySwatch: Colors.pink,
    backgroundColor: Colors.pink,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.deepPurple,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(
          Colors.pink,
        ),
        foregroundColor: MaterialStateProperty.all<Color?>(
          Colors.white,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder?>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color?>(
          Colors.pink,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.pink,
    ),
  );
}
