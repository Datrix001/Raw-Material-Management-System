import 'package:flutter/material.dart';

class MyTheme {

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[400]
    ),
    scaffoldBackgroundColor: Colors.white
  );
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],
      foregroundColor: Colors.white
    ),  


  ); 

}
