import 'package:heroics/data/shared_preferences/shared_preferences.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';

class ThemeRepository {
  final AppSharedPreferences _preferences;

  const ThemeRepository(this._preferences);

  ThemeVariant getTheme() {
    final isDarkTheme = _preferences.isDarkTheme;
    switch (isDarkTheme) {
      case true:
        return const ThemeVariant.darkTheme();
      case false:
        return const ThemeVariant.lightTheme();
      default:
        return const ThemeVariant.defaultTheme();
    }
  }

  void updateTheme(ThemeVariant theme) {
    theme.when(
      darkTheme: () => _preferences.isDarkTheme = true,
      lightTheme: () => _preferences.isDarkTheme = false,
      defaultTheme: () => _preferences.isDarkTheme = null,
    );
  }

  Stream<ThemeVariant> listenTheme() {
    return _preferences.listenIsDarkTheme().map((isDarkTheme) {
      switch (isDarkTheme) {
        case true:
          return const ThemeVariant.darkTheme();
        case false:
          return const ThemeVariant.lightTheme();
        default:
          return const ThemeVariant.defaultTheme();
      }
    });
  }
}
