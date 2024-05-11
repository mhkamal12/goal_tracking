import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  // get theme from shared preferences
  Future<bool> getThemeFromSharedPref() async {
   try{
     final pref = await SharedPreferences.getInstance();
    _isDarkMode = pref.getBool('isDarkMode') ?? false;

    notifyListeners();
    return true;
   }catch(e){
      return false;
   }
  }
}
