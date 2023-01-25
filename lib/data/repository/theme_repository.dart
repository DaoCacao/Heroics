import 'package:heroics/data/shared_preferences/shared_preferences.dart';

class ThemeRepository {
  final AppSharedPreferences _preferences;

  const ThemeRepository(this._preferences);

  bool isDarkTheme() => _preferences.isDarkTheme;

  void setDarkTheme(bool isDarkTheme) => _preferences.isDarkTheme = isDarkTheme;
}
