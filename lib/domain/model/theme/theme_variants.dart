import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_variants.freezed.dart';

/// Theme variants.
@freezed
class ThemeVariant with _$ThemeVariant {
  /// default theme.
  const factory ThemeVariant.defaultTheme() = _DefaultTheme;

  /// light theme.
  const factory ThemeVariant.lightTheme() = _LightTheme;

  /// dark theme.
  const factory ThemeVariant.darkTheme() = _DarkTheme;
}
