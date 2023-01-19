import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemePreference {
  setDarkTheme(bool value);
  bool getTheme();
  Future init();
}

class ThemePreferenceImpl extends ThemePreference {
  final themeStatus = "THEMESTATUS";
  SharedPreferences? prefs;

  @override
  Future init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  @override
  setDarkTheme(bool value) async {
    prefs!.setBool(themeStatus, value);
  }

  @override
  bool getTheme() {
    return prefs!.getBool(themeStatus) ?? false;
  }
}
