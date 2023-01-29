import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';
import 'package:heroics/domain/use_case/theme/check_theme_use_case.dart';
import 'package:heroics/domain/use_case/theme/listen_theme_use_case.dart';
import 'package:heroics/presentation/app/app_bloc.dart';
import 'package:mocktail/mocktail.dart';

class CheckThemeUseCaseMock extends Mock implements CheckThemeUseCase {}

class ListenThemeUseMock extends Mock implements ListenThemeUseCase {}

void main() {
  group("AppBloc", () {
    late CheckThemeUseCase checkThemeUseCase;
    late ListenThemeUseCase listenThemeUseCase;
    late AppBloc bloc;

    setUp(() {
      checkThemeUseCase = CheckThemeUseCaseMock();
      listenThemeUseCase = ListenThemeUseMock();
      bloc = AppBloc(checkThemeUseCase, listenThemeUseCase);
    });

    tearDown(() {
      resetMocktailState();
      bloc.close();
    });

    test(
      "initial state is initial()",
      () {
        expect(bloc.state, const AppState.initial());
      },
    );

    group("init()", () {
      blocTest(
        "call checkThemeUseCase(), emit idle() with theme, "
        "listen to listenThemeUseCase() emit idle() with theme",
        build: () {
          when(() => checkThemeUseCase()).thenAnswer((_) => const ThemeVariant.lightTheme());
          when(() => listenThemeUseCase())
              .thenAnswer((_) => Stream.value(const ThemeVariant.darkTheme()));
          return bloc;
        },
        act: (bloc) => bloc.add(const AppEvent.init()),
        expect: () => [
          const AppState.idle(ThemeVariant.lightTheme()),
          const AppState.idle(ThemeVariant.darkTheme()),
        ],
        verify: (_) {
          verify(() => checkThemeUseCase()).called(1);
        },
      );
    });

    group("updateTheme()", () {
      blocTest(
        "emit idle() with the theme",
        build: () => bloc,
        act: (bloc) => bloc.add(const AppEvent.updateTheme(ThemeVariant.defaultTheme())),
        expect: () => [const AppState.idle(ThemeVariant.defaultTheme())],
      );
    });
  });
}
