import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/data/repository/theme_repository.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';
import 'package:heroics/domain/use_case/theme/update_theme_use_case.dart';
import 'package:mocktail/mocktail.dart';

class ThemeRepositoryMock extends Mock implements ThemeRepository {}

void main() {
  group("UpdateThemeUseCase", () {
    late ThemeRepository themeRepository;
    late UpdateThemeUseCase updateThemeUseCase;

    setUp(() {
      themeRepository = ThemeRepositoryMock();
      updateThemeUseCase = UpdateThemeUseCase(themeRepository);
    });

    tearDown(() {
      resetMocktailState();
    });

    test("update dark theme", () {
      updateThemeUseCase(const ThemeVariant.darkTheme());
      verify(() => themeRepository.updateTheme(const ThemeVariant.darkTheme())).called(1);
    });

    test("update light theme", () {
      updateThemeUseCase(const ThemeVariant.lightTheme());
      verify(() => themeRepository.updateTheme(const ThemeVariant.lightTheme())).called(1);
    });

    test("update default theme", () {
      updateThemeUseCase(const ThemeVariant.defaultTheme());
      verify(() => themeRepository.updateTheme(const ThemeVariant.defaultTheme())).called(1);
    });
  });
}
