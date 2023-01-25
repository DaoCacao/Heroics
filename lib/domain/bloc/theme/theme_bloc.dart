import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/data/repository/theme_repository.dart';

part 'theme_bloc.freezed.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository _themeRepository;

  ThemeBloc(this._themeRepository)
      : super(_themeRepository.isDarkTheme()
            ? ThemeState.darkTheme()
            : ThemeState.lightTheme()) {
    on<ThemeEvent>((event, emit) => event.map(
          switchTheme: (event) => _switchTheme(event, emit),
        ));
  }

  void _switchTheme(_SwitchTheme event, Emitter<ThemeState> emit) {
    _themeRepository.setDarkTheme(event.isDarkTheme);
    if (event.isDarkTheme) {
      emit(ThemeState.darkTheme());
    } else {
      emit(ThemeState.lightTheme());
    }
  }
}

@freezed
class ThemeEvent with _$ThemeEvent {
  factory ThemeEvent.switchTheme(bool isDarkTheme) = _SwitchTheme;
}

@freezed
class ThemeState with _$ThemeState {
  factory ThemeState.darkTheme() = _DarkTheme;

  factory ThemeState.lightTheme() = _LightTheme;

// TODO system default theme state
}
