import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
ThemeData lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      elevation: 20,
    ),
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.green),
    primarySwatch: Colors.green,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        elevation: 0,
        //backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    textTheme: TextTheme(
      bodyText1: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
      bodyText2: TextStyle(color: Colors.grey[600], fontSize: 15),
    ));
