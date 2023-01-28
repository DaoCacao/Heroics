import 'package:heroics/data/repository/theme_repository.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';

/// Listen theme use case.
class ListenThemeUseCase {
  final ThemeRepository _themeRepository;

  ListenThemeUseCase(this._themeRepository);

  /// Listen if dark theme is enabled.
  Stream<ThemeVariant> call() => _themeRepository.listenTheme();
}
