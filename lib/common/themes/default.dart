import 'package:flutter/material.dart';

var defaultColor = const Color(0xff00A884);

ThemeData defaultDarkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: defaultColor,
    highlightColor: defaultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 1,
      backgroundColor: Color(0xff1F2C34),
    ),
    scaffoldBackgroundColor: const Color(0xff121B22),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      floatingLabelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
      errorStyle: TextStyle(color: Colors.white),
      helperStyle: TextStyle(color: Colors.white),
      prefixStyle: TextStyle(color: Colors.white),
      suffixStyle: TextStyle(color: Colors.white),
      counterStyle: TextStyle(color: Colors.white),
    ),
    textTheme: const TextTheme()
        .copyWith(
          displayLarge: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: defaultColor,
          ),
          displaySmall: const TextStyle(),
          headlineMedium: const TextStyle(),
          headlineSmall: const TextStyle(),
          titleLarge: const TextStyle(),
          bodyLarge: const TextStyle(
            fontSize: 14,
          ),
          bodyMedium: const TextStyle(),
        )
        .apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
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
          displayLarge: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: defaultColor,
          ),
        )
        .apply(
          bodyColor: Colors.pink,
          displayColor: Colors.pink,
        ),
  );
}
