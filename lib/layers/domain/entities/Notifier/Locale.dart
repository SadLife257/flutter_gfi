import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  LocaleProvider() {
    initialize();
  }

  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locale = await prefs.getString("locale");
    if(locale != null) {
      _locale = Locale(locale);
    }
    notifyListeners();
  }

  set(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}