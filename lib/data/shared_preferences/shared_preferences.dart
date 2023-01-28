import 'package:shared_preferences/shared_preferences.dart';

import 'model/preference.dart';

class AppSharedPreferences {
  final SharedPreferences _preferences;

  /// Is dark theme enabled.
  /// If null, system theme will be used.
  /// If true, dark theme will be used.
  /// If false, light theme will be used.
  late PreferenceEntry<bool?> _isDarkTheme;

  AppSharedPreferences(this._preferences) {
    _isDarkTheme = PreferenceEntry("is_dark_theme", null, _preferences);
  }

  bool? get isDarkTheme => _isDarkTheme.get();

  set isDarkTheme(bool? value) => _isDarkTheme.set(value);

  Stream<bool?> listenIsDarkTheme() => _isDarkTheme.listen();
}
