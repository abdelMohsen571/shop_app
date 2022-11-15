import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
    ),
    primarySwatch: Colors.pink,
    fontFamily: 'Jannah',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 80,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black45));
ThemeData drakTheme = ThemeData();
