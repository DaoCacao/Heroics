import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/data/repository/theme_repository.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';
import 'package:heroics/domain/use_case/theme/check_theme_use_case.dart';
import 'package:mocktail/mocktail.dart';

class ThemeRepositoryMock extends Mock implements ThemeRepository {}

void main() {
  late ThemeRepository themeRepository;
  late CheckThemeUseCase checkThemeUseCase;

  group("CheckThemeUseCase", () {
    setUp(() {
      themeRepository = ThemeRepositoryMock();
      checkThemeUseCase = CheckThemeUseCase(themeRepository);
    });

    tearDown(() {
      resetMocktailState();
    });

    test("return dark theme when theme is dark", () {
      when(() => themeRepository.getTheme()).thenReturn(const ThemeVariant.darkTheme());
      expect(checkThemeUseCase(), const ThemeVariant.darkTheme());
    });

    test("return light theme when theme is light", () {
      when(() => themeRepository.getTheme()).thenReturn(const ThemeVariant.lightTheme());
      expect(checkThemeUseCase(), const ThemeVariant.lightTheme());
    });

    test("return default theme when theme is default", () {
      when(() => themeRepository.getTheme()).thenReturn(const ThemeVariant.defaultTheme());
      expect(checkThemeUseCase(), const ThemeVariant.defaultTheme());
    });
  });
}
