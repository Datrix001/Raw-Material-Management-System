import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey[400]),
    scaffoldBackgroundColor: Colors.white,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[400],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      elevation: 10,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[800],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      elevation: 10,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.black,
    ),
  );
}
