import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';
import 'package:heroics/domain/use_case/sign_out/sign_out_use_case.dart';
import 'package:heroics/domain/use_case/theme/check_theme_use_case.dart';
import 'package:heroics/domain/use_case/theme/update_theme_use_case.dart';

part 'settings_bloc.freezed.dart';

/// Settings bloc.
/// This bloc will emit [SettingsState] when state is changed.
/// This bloc will handle [SettingsEvent] when event is added.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final CheckThemeUseCase _checkThemeUseCase;
  final UpdateThemeUseCase _updateThemeUseCase;
  final SignOutUseCase _signOutUseCase;

  SettingsBloc(this._checkThemeUseCase, this._updateThemeUseCase, this._signOutUseCase)
      : super(const SettingsState.initial()) {
    on<SettingsEvent>((event, emit) => event.map(
          init: (event) => _init(event, emit),
          changeTheme: (event) => _changeTheme(event, emit),
          signOut: (event) => _signOut(event, emit),
        ));
  }

  /// Function to handle [SettingsEvent.init].
  /// Check theme state and emit [SettingsEvent.idle].
  void _init(_Init event, Emitter<SettingsState> emit) async {
    final theme = _checkThemeUseCase();
    emit(SettingsState.idle(theme));
  }

  /// Function to handle [SettingsEvent.changeTheme].
  /// Change theme and emit [SettingsEvent.idle].
  void _changeTheme(_ChangeTheme event, Emitter<SettingsState> emit) async {
    _updateThemeUseCase(event.theme);
    emit(SettingsState.idle(event.theme));
  }

  /// Function to handle [SettingsEvent.signOut].
  /// Sign out user and emit [SettingsEvent.unauthorized].
  void _signOut(_SignOut event, Emitter<SettingsState> emit) async {
    await _signOutUseCase();
    emit(const SettingsState.unauthorized());
  }
}

/// Settings event.
@freezed
class SettingsEvent with _$SettingsEvent {
  /// Initialize.
  const factory SettingsEvent.init() = _Init;

  /// Change theme.
  const factory SettingsEvent.changeTheme(ThemeVariant theme) = _ChangeTheme;

  /// Sign out.
  const factory SettingsEvent.signOut() = _SignOut;
}

/// Settings state.
@freezed
class SettingsState with _$SettingsState {
  /// Initial state.
  const factory SettingsState.initial() = _Initial;

  /// Idle state.
  const factory SettingsState.idle(ThemeVariant themeVariant) = _Idle;

  /// Unauthorized state.
  const factory SettingsState.unauthorized() = _Unauthorized;
}
