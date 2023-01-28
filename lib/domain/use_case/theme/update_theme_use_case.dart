import 'package:heroics/data/repository/theme_repository.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';

/// Update theme use case.
class UpdateThemeUseCase {
  final ThemeRepository _themeRepository;

  UpdateThemeUseCase(this._themeRepository);

  /// Update theme.
  void call(ThemeVariant theme) => _themeRepository.updateTheme(theme);
}
