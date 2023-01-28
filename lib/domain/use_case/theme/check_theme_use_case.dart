import 'package:heroics/data/repository/theme_repository.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';

/// Check theme use case.
class CheckThemeUseCase {
  final ThemeRepository _themeRepository;

  CheckThemeUseCase(this._themeRepository);

  /// Check if dark theme is enabled.
  ThemeVariant call() => _themeRepository.getTheme();
}
