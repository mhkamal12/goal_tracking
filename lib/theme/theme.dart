// Light mode theme data
import 'package:flutter/material.dart';

ThemeData lightThemeData() {
  return ThemeData(
      appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
      primaryColor: Colors.lightBlue,
      useMaterial3: true,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: Color.fromARGB(255, 243, 243, 243),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide:
              BorderSide(color: Color.fromARGB(255, 128, 128, 128), width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        hintStyle: TextStyle(color: Color.fromARGB(255, 128, 128, 128)),
      ),
      colorScheme: ColorScheme(
        background: Colors.white,
        brightness: Brightness.light,
        primary: Colors.lightBlue,
        onPrimary: Colors.white,
        secondary: Colors.lightBlue,
        onSecondary: Colors.white,
        surface: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
      ));
}

// Dark mode theme data
ThemeData darkThemeData() {
  return ThemeData(
      appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
      primaryColor: Colors.blueGrey,
      useMaterial3: true,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide:
              BorderSide(color: Color.fromARGB(255, 51, 51, 51), width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: Color.fromARGB(255, 18, 18, 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        elevation: 16.0,
        backgroundColor: Color.fromARGB(255, 9, 9, 9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
      ),
      colorScheme: ColorScheme(
        background: Color.fromARGB(255, 7, 7, 7),
        onBackground: Colors.white,
        brightness: Brightness.dark,
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
        secondary: Colors.blueGrey,
        onSecondary: Colors.white,
        surface: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        onSurface: Colors.white,
      ));
}
