import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/data/repository/auth_repository.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthState.initial()) {
    on<AuthEvent>((event, emit) => event.map(
          check: (event) => _check(event, emit),
          signOut: (event) => _signOut(event, emit),
        ));
  }

  void _check(_Check event, Emitter<AuthState> emit) async {
    final isAuthorized = _authRepository.isAuthorized();
    if (isAuthorized) {
      emit(AuthState.authorized());
    } else {
      emit(AuthState.unauthorized());
    }
  }

  void _signOut(_SignOut event, Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(AuthState.unauthorized());
  }
}

@freezed
class AuthEvent with _$AuthEvent {
  factory AuthEvent.check() = _Check;

  factory AuthEvent.signOut() = _SignOut;
}

@freezed
class AuthState with _$AuthState {
  factory AuthState.initial() = _Initial;

  factory AuthState.unauthorized() = _Unauthorized;

  factory AuthState.authorized() = _Authorized;
}
