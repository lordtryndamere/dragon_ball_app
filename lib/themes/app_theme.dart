import 'package:flutter/material.dart';

class AppTheme {
  static Color? primary = Colors.orange[900];
  static final ThemeData lighTheme = ThemeData.light().copyWith(
      //Color primario
      primaryColor: primary,
      // AppBar THeme
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        elevation: 2,
      ),
      backgroundColor: Colors.orange[100],
      textButtonTheme:
          TextButtonThemeData(style: TextButton.styleFrom(primary: primary)),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: primary),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: primary, shape: const StadiumBorder(), elevation: 0)),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primary),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary!),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary!),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
      ));
}
