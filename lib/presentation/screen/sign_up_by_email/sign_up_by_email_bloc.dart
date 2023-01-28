import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';
import 'package:heroics/domain/use_case/validation/validate_confirm_password_use_case.dart';
import 'package:heroics/domain/use_case/validation/validate_email_use_case.dart';
import 'package:heroics/domain/use_case/validation/validate_password_use_case.dart';

part 'sign_up_by_email_bloc.freezed.dart';

/// Sign up by email bloc.
/// This bloc is used to handle sign up by email.
/// This bloc will emit [SignUpByEmailState] when state is changed.
/// This bloc will handle [SignUpByEmailEvent] when event is added.
class SignUpByEmailBloc extends Bloc<SignUpByEmailEvent, SignUpByEmailState> {
  final SignUpByEmailUseCase _signUpByEmailUseCase;
  final ValidateEmailUseCase _validateEmailUseCase;
  final ValidatePasswordUseCase _validatePasswordUseCase;
  final ValidateConfirmPasswordUseCase _validateConfirmPasswordUseCase;

  SignUpByEmailBloc(
    this._signUpByEmailUseCase,
    this._validateEmailUseCase,
    this._validatePasswordUseCase,
    this._validateConfirmPasswordUseCase,
  ) : super(const SignUpByEmailState.idle()) {
    on<SignUpByEmailEvent>((event, emit) => event.map(
          onEmailChange: (event) => _onEmailChange(event, emit),
          onPasswordChange: (event) => _onPasswordChange(event, emit),
          onConfirmPasswordChange: (event) => _onConfirmPasswordChange(event, emit),
          onSignUp: (event) => _onSignUp(event, emit),
        ));
  }

  SignUpByEmailBloc.inject() : this(inject(), inject(), inject(), inject());

  /// Function to handle [SignUpByEmailEvent.onEmailChange].
  /// Emit idle() if state is not [_Loading].
  void _onEmailChange(_OnEmailChange event, Emitter<SignUpByEmailState> emit) {
    if (state is _Loading) return;
    emit(const SignUpByEmailState.idle());
  }

  /// Function to handle [SignUpByEmailEvent.onPasswordChange].
  /// Emit idle() if state is not [_Loading].
  void _onPasswordChange(_OnPasswordChange event, Emitter<SignUpByEmailState> emit) {
    if (state is _Loading) return;
    emit(const SignUpByEmailState.idle());
  }

  /// Function to handle [SignUpByEmailEvent.onConfirmPasswordChange].
  /// Emit idle() if state is not [_Loading].
  void _onConfirmPasswordChange(_OnConfirmPasswordChange event, Emitter<SignUpByEmailState> emit) {
    if (state is _Loading) return;
    emit(const SignUpByEmailState.idle());
  }

  /// Function to handle [SignUpByEmailEvent.onSignUp].
  /// Validate form, emit loading, try to sign up by email, emit new state.
  /// If email is invalid, emit failure state with [error] is [SignUpByEmailStateError.invalidEmail].
  /// If password is invalid, emit failure state with [error] is [SignUpByEmailStateError.weakPassword].
  /// If confirm password is invalid, emit failure state with [error] is [SignUpByEmailStateError.confirmPasswordNotMatch].
  /// Emit loading state.
  /// Sign up by email.
  /// If sign up by email is success, emit success state.
  /// If sign up by email is failure with email is already in use, emit failure state with [error] is [SignUpByEmailStateError.alreadyInUse].
  /// If sign up by email is failure with email is invalid, emit failure state with [error] is [SignUpByEmailStateError.invalidEmail].
  /// If sign up by email is failure with password is weak, emit failure state with [error] is [SignUpByEmailStateError.weakPassword].
  void _onSignUp(_OnSignUp event, Emitter<SignUpByEmailState> emit) async {
    /// Validate email.
    if (!_validateEmailUseCase(event.email)) {
      emit(const SignUpByEmailState.failure(SignUpByEmailStateError.invalidEmail()));
      return;
    }

    /// Validate password.
    if (!_validatePasswordUseCase(event.password)) {
      emit(const SignUpByEmailState.failure(SignUpByEmailStateError.weakPassword()));
      return;
    }

    /// Validate confirm password.
    if (!_validateConfirmPasswordUseCase(event.password, event.confirmPassword)) {
      emit(const SignUpByEmailState.failure(SignUpByEmailStateError.confirmPasswordNotMatch()));
      return;
    }

    /// Emits loading state.
    emit(const SignUpByEmailState.loading());

    /// Sign up by email.
    final result = await _signUpByEmailUseCase(event.email, event.password);

    /// Emits new state.
    result.when(
        success: () => emit(const SignUpByEmailState.success()),
        failure: (error) => emit(SignUpByEmailState.failure(error.when(
              alreadyInUse: () => const SignUpByEmailStateError.alreadyInUse(),
              invalidEmail: () => const SignUpByEmailStateError.invalidEmail(),
              weakPassword: () => const SignUpByEmailStateError.weakPassword(),
            ))));
  }
}

/// Sign up by email event.
@freezed
class SignUpByEmailEvent with _$SignUpByEmailEvent {
  /// Event when email change.
  /// Using [email].
  const factory SignUpByEmailEvent.onEmailChange(
    String email,
  ) = _OnEmailChange;

  /// Event when password change.
  /// Using [password].
  const factory SignUpByEmailEvent.onPasswordChange(
    String password,
  ) = _OnPasswordChange;

  /// Event when confirm password change.
  /// Using [confirmPassword].
  const factory SignUpByEmailEvent.onConfirmPasswordChange(
    String confirmPassword,
  ) = _OnConfirmPasswordChange;

  /// Event when sign up.
  /// Using [email], [password], [confirmPassword].
  const factory SignUpByEmailEvent.onSignUp(
    String email,
    String password,
    String confirmPassword,
  ) = _OnSignUp;
}

/// Sign up by email state.
@freezed
class SignUpByEmailState with _$SignUpByEmailState {
  /// Idle state.
  /// Default state.
  const factory SignUpByEmailState.idle() = _Idle;

  /// Loading state.
  /// Emits while sign up by email in progress.
  const factory SignUpByEmailState.loading() = _Loading;

  /// Success state.
  /// Emits when sign up by email is success.
  const factory SignUpByEmailState.success() = _Success;

  /// Failure state.
  /// Emits when sign up by email is failure.
  const factory SignUpByEmailState.failure(
    SignUpByEmailStateError error,
  ) = _Failure;
}

/// Sign up by email error.
@freezed
class SignUpByEmailStateError with _$SignUpByEmailStateError {
  /// Error when email already in use.
  const factory SignUpByEmailStateError.alreadyInUse() = _AlreadyInUse;

  /// Error when email invalid.
  const factory SignUpByEmailStateError.invalidEmail() = _InvalidEmail;

  /// Error when password weak.
  const factory SignUpByEmailStateError.weakPassword() = _WeakPassword;

  /// Error when confirm password not match.
  const factory SignUpByEmailStateError.confirmPasswordNotMatch() = _ConfirmPasswordNotMatch;
}
