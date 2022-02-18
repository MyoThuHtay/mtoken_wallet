import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  ThemeProvider(BuildContext context);

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blueGrey.shade700,
    primaryColor: Colors.black54,
    colorScheme: const ColorScheme.dark(),
    iconTheme: const IconThemeData(color: Colors.white70),
    indicatorColor: Colors.white12,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.blueGrey.shade700, // This is a custom color variable
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
    ),

  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blueAccent,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: Colors.black54),
    indicatorColor: Colors.black12,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.blueAccent, // This is a custom color variable
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      subtitle1: TextStyle(color: Colors.black),
    ),
  );
}
