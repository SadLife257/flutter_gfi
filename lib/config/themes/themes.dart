import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Color.fromARGB(255, 12, 12, 12),
    secondary: Colors.black26,
    tertiary: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black
    )
  )
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color.fromARGB(255, 12, 12, 12),
    primary: Colors.white,
    secondary: Colors.white70,
    tertiary: Colors.black,
  ),
  textTheme: TextTheme(
      bodyLarge: TextStyle(
          color: Colors.white
      )
  )
);