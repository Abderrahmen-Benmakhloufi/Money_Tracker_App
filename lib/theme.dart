import 'package:flutter/material.dart';

var kColorScheem = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 198, 251, 144),
);

var kDarkColorScheem = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

// 2. Define the actual Theme Data
final lightTheme = ThemeData().copyWith(
  colorScheme: kColorScheem,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kColorScheem.onPrimaryContainer,
    foregroundColor: kColorScheem.primaryContainer,
  ),
  cardTheme: const CardThemeData().copyWith(
    color: kColorScheem.secondaryContainer,
    elevation: 12,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: kColorScheem.onPrimary),
  ),
  // textTheme: ThemeData().textTheme.copyWith(
  //   titleLarge: ThemeData().textTheme
  // )
);

final darkTheme = ThemeData.dark().copyWith(colorScheme: kDarkColorScheem);
