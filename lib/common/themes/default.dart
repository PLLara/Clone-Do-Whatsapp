import 'package:flutter/material.dart';

var defaultColor = const Color(0xff00A884);

ThemeData defaultDarkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: defaultColor,
    highlightColor: defaultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    appBarTheme: const AppBarTheme(elevation: 1),
    textTheme: const TextTheme()
        .copyWith(
          headline1: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
          headline2: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: defaultColor,
          ),
        )
        .apply(bodyColor: Colors.white, displayColor: Colors.white),
  );
}

ThemeData defaultLightTheme() {
  return ThemeData.light().copyWith(
    primaryColor: defaultColor,
    highlightColor: defaultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    appBarTheme: const AppBarTheme(elevation: 1),
    textTheme: const TextTheme()
        .copyWith(
          headline1: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
          headline2: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: defaultColor,
          ),
        )
        .apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
  );
}
