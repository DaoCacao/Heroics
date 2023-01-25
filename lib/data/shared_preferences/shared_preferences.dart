import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  final SharedPreferences _preferences;

  const AppSharedPreferences(this._preferences);

  bool get isDarkTheme => _preferences.getBool("is_dark_theme") ?? false;

  set isDarkTheme(bool value) => _preferences.setBool("is_dark_theme", value);
}
