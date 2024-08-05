import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color.fromARGB(255, 248, 249, 250),
    primary: Color.fromARGB(255, 34, 34, 34),
    secondary: Colors.black26,
    tertiary: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black
    )
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color.fromARGB(255, 12, 12, 12),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color.fromARGB(255, 34, 34, 34),
    primary: Colors.white,
    secondary: Color.fromARGB(255, 134, 140, 158),
    tertiary: Color.fromARGB(255, 34, 34, 34),
  ),
  textTheme: TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white
      )
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
  ),
);