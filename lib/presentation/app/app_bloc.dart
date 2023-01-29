import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';
import 'package:heroics/domain/use_case/theme/check_theme_use_case.dart';
import 'package:heroics/domain/use_case/theme/listen_theme_use_case.dart';

part 'app_bloc.freezed.dart';

/// App bloc.
/// This bloc will emit [AppState] when state is changed.
/// This bloc will handle [AppEvent] when event is added.
class AppBloc extends Bloc<AppEvent, AppState> {
  final CheckThemeUseCase _checkThemeUseCase;
  final ListenThemeUseCase _listenThemeUseCase;

  AppBloc(this._checkThemeUseCase, this._listenThemeUseCase) : super(const AppState.initial()) {
    on<AppEvent>((event, emit) => event.map(
          init: (event) => _init(event, emit),
          updateTheme: (event) => _updateTheme(event, emit),
        ));
  }

  /// Function to handle [AppEvent.init].
  /// Check theme and emit [AppState.idle].
  /// Listen theme and emit [AppState.idle] with new theme.
  void _init(_Init event, Emitter<AppState> emit) {
    final theme = _checkThemeUseCase();
    emit(AppState.idle(theme));
    _listenThemeUseCase().listen((theme) {
      add(AppEvent.updateTheme(theme));
    });
  }

  /// Function to handle [AppEvent.updateTheme].
  /// Emit [AppState.idle] with new theme.
  void _updateTheme(_UpdateTheme event, Emitter<AppState> emit) {
    emit(AppState.idle(event.theme));
  }
}

/// App event.
@freezed
class AppEvent with _$AppEvent {
  /// init app state.
  const factory AppEvent.init() = _Init;

  /// update app theme.
  const factory AppEvent.updateTheme(ThemeVariant theme) = _UpdateTheme;
}

/// App state.
@freezed
class AppState with _$AppState {
  /// Initial state.
  const factory AppState.initial() = _Initial;

  /// Idle state.
  const factory AppState.idle(ThemeVariant theme) = _Idle;
}
