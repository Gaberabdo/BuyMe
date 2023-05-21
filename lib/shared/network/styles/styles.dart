import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/network/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Poppens',
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    color: Colors.white,
    elevation: 0.0,
  ),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: offWhite,
    selectedItemColor: teal,
    showUnselectedLabels: true,
    unselectedItemColor: black,
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'Poppens',
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: asmar,
    ),
    color: asmar,
    elevation: 0.0,
  ),
  scaffoldBackgroundColor: asmar,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: asmarFate7,
    selectedLabelStyle: const TextStyle(
      color: Colors.white,
    ),
    selectedItemColor: teal,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: skin,
    elevation: 0.0,
  ),
);
