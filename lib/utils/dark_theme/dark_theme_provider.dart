import 'package:expense_tracker/utils/dark_theme/dark_theme_pref.dart';
import 'package:expense_tracker/utils/locator.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    init();
  }

  init() {
    darkTheme = themePreference.getTheme();
  }

  final ThemePreference themePreference = serviceLocator<ThemePreference>();

  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    themePreference.setDarkTheme(value);
    notifyListeners();
  }
}
