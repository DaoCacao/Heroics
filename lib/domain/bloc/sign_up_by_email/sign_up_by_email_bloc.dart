import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';

part 'sign_up_by_email_bloc.freezed.dart';

class SignUpByEmailBloc extends Bloc<SignUpByEmailEvent, SignUpByEmailState> {
  final SignUpByEmailUseCase _signUpByEmailUseCase;

  SignUpByEmailBloc(
    this._signUpByEmailUseCase,
  ) : super(SignUpByEmailState.initial()) {
    on<SignUpByEmailEvent>((event, emit) => event.map(
          signUp: (event) => _signUp(event, emit),
        ));
  }

  void _signUp(
    _SignUp event,
    Emitter<SignUpByEmailState> emit,
  ) async {
    emit(SignUpByEmailState.loading());
    final result = await _signUpByEmailUseCase(event.email, event.password);
    emit(
      result.when(
        success: (user) => SignUpByEmailState.authorized(),
        alreadyInUse: () => SignUpByEmailState.alreadyInUse(),
        invalidEmail: () => SignUpByEmailState.invalidEmail(),
        weakPassword: () => SignUpByEmailState.weakPassword(),
      ),
    );
  }
}

@freezed
class SignUpByEmailEvent with _$SignUpByEmailEvent {
  factory SignUpByEmailEvent.signUp(String email, String password) = _SignUp;
}

@freezed
class SignUpByEmailState with _$SignUpByEmailState {
  factory SignUpByEmailState.initial() = _Initial;

  factory SignUpByEmailState.loading() = _Loading;

  factory SignUpByEmailState.authorized() = _Authorized;

  factory SignUpByEmailState.alreadyInUse() = _AlreadyInUse;

  factory SignUpByEmailState.invalidEmail() = _InvalidEmail;

  factory SignUpByEmailState.weakPassword() = _WeakPassword;
}
