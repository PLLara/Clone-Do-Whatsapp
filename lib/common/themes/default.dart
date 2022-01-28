import 'package:flutter/material.dart';

// var defaultAppTheme = new ThemeData.dark().copyWith(
//   primaryColor: Colors.yellow,
//   highlightColor: Colors.yellow,
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//     backgroundColor: Colors.yellow,
//   ),
//   textTheme: const TextTheme().copyWith(
//     headline1: const TextStyle(
//       fontSize: 30,
//       fontWeight: FontWeight.w800,
//     ),
//   ),
// );

var defaultColor = Colors.yellow;

defaultAppTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: defaultColor,
    highlightColor: defaultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    textTheme: const TextTheme().copyWith(
      headline1: const TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.w800,
      ),
      headline2: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: defaultColor,
      ),
    ),
  );
}
