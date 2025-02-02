import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gfi/config/themes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? _currentTheme;
  ThemeData? get currentTheme => _currentTheme;

  ThemeProvider() {
    initialize();
  }

  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? isDarkMode = await prefs.getInt("isDarkMode");
    if(isDarkMode == null) {
      adaptDarkMode();
    }
    else {
      if(isDarkMode == 0) _currentTheme = lightTheme;
      else _currentTheme = darkTheme;
    }
    notifyListeners();
  }

  void adaptDarkMode() {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool systemDarkMode = brightness == Brightness.dark;
    if(systemDarkMode) _currentTheme = darkTheme;
    else _currentTheme = lightTheme;
  }

  set(bool isDarkMode) {
    if(isDarkMode) _currentTheme = darkTheme;
    else _currentTheme = lightTheme;
    notifyListeners();
  }

  bool isDarkMode() {
    if(_currentTheme == null) {
      var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      bool systemDarkMode = brightness == Brightness.dark;
      return systemDarkMode;
    }
    if(_currentTheme == darkTheme) {
      return true;
    }
    return false;
  }
}