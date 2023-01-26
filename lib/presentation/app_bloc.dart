import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/data/repository/auth_repository.dart';

part 'app_bloc.freezed.dart';

/// App bloc.
/// This bloc is used to handle sign up by email.
/// This bloc will emit [AppState] when state is changed.
/// This bloc will handle [AppEvent] when event is added.
class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;

  AppBloc(
    this._authRepository,
  ) : super(const AppState.initial()) {
    on<AppEvent>((event, emit) => event.map(
          check: (event) => _check(event, emit),
        ));
  }

  /// Function to handle [AppEvent.check].
  /// This function will check if user is authenticated.яя
  /// If user is authenticated, this function will emit [AppState.authenticated].
  /// If user is not authenticated, this function will emit [AppState.unauthenticated].
  void _check(_Check event, Emitter<AppState> emit) async {
    final isAuthorized = _authRepository.isAuthorized();
    if (isAuthorized) {
      emit(const AppState.authenticated());
    } else {
      emit(const AppState.unauthenticated());
    }
  }
}

/// App event.
@freezed
class AppEvent with _$AppEvent {
  /// Check if user is authenticated.
  const factory AppEvent.check() = _Check;
}

/// App state.
@freezed
class AppState with _$AppState {
  /// Initial state.
  const factory AppState.initial() = _Initial;

  /// Unauthenticated state.
  const factory AppState.unauthenticated() = _Unauthenticated;

  /// Authenticated state.
  const factory AppState.authenticated() = _Authenticated;
}
