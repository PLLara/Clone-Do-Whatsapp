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
    ),
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
          headline1: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
          headline2: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: defaultColor,
          ),
          headline3: const TextStyle(),
          headline4: const TextStyle(),
          headline5: const TextStyle(),
          headline6: const TextStyle(),
          bodyText1: const TextStyle(
            fontSize: 14,
          ),
          bodyText2: const TextStyle(),
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
          bodyColor: Colors.pink,
          displayColor: Colors.pink,
        ),
  );
}
