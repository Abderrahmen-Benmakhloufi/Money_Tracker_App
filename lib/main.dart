import 'package:flutter/material.dart';
import 'widgets/EXPENSES.dart';
import 'theme.dart';

var kColorScheem = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 198, 251, 144),
);
void main() {
  runApp(
    MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Expenses(),
    ),
  );
}
