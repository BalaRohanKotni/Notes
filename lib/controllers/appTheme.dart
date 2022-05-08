// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:notes/controllers/dataServices.dart';
import '../constants.dart';

class AppTheme with ChangeNotifier {
  var uid;
  AppTheme(this.uid);

  void toggleTheme() async {
    bool currentTheme = await getThemeFirestore(uid);
    updateThemeFirestore(uid, !currentTheme);
    notifyListeners();
  }

  ThemeData get lightTheme {
    return ThemeData(
      secondaryHeaderColor: kCaledonBLue,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyText2: TextStyle(
          color: kSpaceCadet,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(29, 0, 0, 0)),
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
      secondaryHeaderColor: kCaledonBLue,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1A1A1A),
      ),
      cardTheme: const CardTheme(
        color: Color(0xFF1A1A1A),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFF1A1A1A),
      ),
      textTheme: const TextTheme(
        bodyText2: TextStyle(
          color: Colors.white,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(64, 255, 255, 255)),
        ),
      ),
    );
  }
}
