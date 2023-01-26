import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';

part 'sign_up_by_email_bloc.freezed.dart';

/// Sign up by email bloc.
/// This bloc is used to handle sign up by email.
/// This bloc will emit [SignUpByEmailState] when state is changed.
/// This bloc will handle [SignUpByEmailEvent] when event is added.
class SignUpByEmailBloc extends Bloc<SignUpByEmailEvent, SignUpByEmailState> {
  /// Regex to validate email.
  static const String _emailRegex = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  /// Regex to validate password.
  static const String _passwordRegex = r"^[a-zA-Z0-9]{6,}$";

  final SignUpByEmailUseCase _signUpByEmailUseCase;

  SignUpByEmailBloc(
    this._signUpByEmailUseCase,
  ) : super(SignUpByEmailState.initial()) {
    on<SignUpByEmailEvent>((event, emit) => event.map(
          onEmailChange: (event) => _onEmailChange(event, emit),
          onPasswordChange: (event) => _onPasswordChange(event, emit),
          onConfirmPasswordChange: (event) =>
              _onConfirmPasswordChange(event, emit),
          onSignUp: (event) => _onSignUp(event, emit),
        ));
  }

  /// Function to handle [SignUpByEmailEvent.onEmailChange].
  /// Emit new state with [email] and [error] is null.
  void _onEmailChange(
    _OnEmailChange event,
    Emitter<SignUpByEmailState> emit,
  ) async {
    emit(state.copyWith(
      email: event.email,
      error: null,
    ));
  }

  /// Function to handle [SignUpByEmailEvent.onPasswordChange].
  /// Emit new state with [password] and [error] is null.
  void _onPasswordChange(
    _OnPasswordChange event,
    Emitter<SignUpByEmailState> emit,
  ) async {
    emit(state.copyWith(
      password: event.password,
      error: null,
    ));
  }

  /// Function to handle [SignUpByEmailEvent.onConfirmPasswordChange].
  /// Emit new state with [confirmPassword] and [error] is null.
  void _onConfirmPasswordChange(
    _OnConfirmPasswordChange event,
    Emitter<SignUpByEmailState> emit,
  ) async {
    emit(state.copyWith(
      confirmPassword: event.confirmPassword,
      error: null,
    ));
  }

  /// Function to handle [SignUpByEmailEvent.onSignUp].
  /// Validate form, emit loading, try to sign up by email, emit new state.
  /// If email is invalid, emit new state with [error] is [SignUpByEmailStateError.invalidEmail].
  /// If password is invalid, emit new state with [error] is [SignUpByEmailStateError.weakPassword].
  /// If confirm password is invalid, emit new state with [error] is [SignUpByEmailStateError.confirmPasswordNotMatch].
  /// Emit new state with [isLoading] is true.
  /// After sign up emit state with [isLoading] is false.
  /// If sign up by email is success, emit new state with [isSuccess] is true, [error] is null.
  /// If sign up by email is failure with email is already in use, emit new state with [error] is [SignUpByEmailStateError.alreadyInUse].
  /// If sign up by email is failure with email is invalid, emit new state with [error] is [SignUpByEmailStateError.invalidEmail].
  /// If sign up by email is failure with password is weak, emit new state with [error] is [SignUpByEmailStateError.weakPassword].
  void _onSignUp(
    _OnSignUp event,
    Emitter<SignUpByEmailState> emit,
  ) async {
    /// Validate email, password, confirm password.
    if (!_isEmailValid(event.email)) {
      emit(state.copyWith(
        email: event.email,
        error: const SignUpByEmailStateError.invalidEmail(),
      ));
      return;
    }
    if (!_isPasswordValid(event.password)) {
      emit(state.copyWith(
        password: event.password,
        error: const SignUpByEmailStateError.weakPassword(),
      ));
      return;
    }
    if (!_isConfirmPasswordValid(
      event.password,
      event.confirmPassword,
    )) {
      emit(state.copyWith(
        confirmPassword: event.confirmPassword,
        error: const SignUpByEmailStateError.confirmPasswordNotMatch(),
      ));
      return;
    }
    emit(state.copyWith(isLoading: true));
    final result = await _signUpByEmailUseCase(
      email: state.email,
      password: state.password,
    );
    result.when(
      success: (profile) => emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: null,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: error.when(
            alreadyInUse: () => const SignUpByEmailStateError.alreadyInUse(),
            invalidEmail: () => const SignUpByEmailStateError.invalidEmail(),
            weakPassword: () => const SignUpByEmailStateError.weakPassword(),
          ),
        ),
      ),
    );
  }

  /// Function to validate [email].
  /// [email] must match with regex.
  bool _isEmailValid(String email) => RegExp(_emailRegex).hasMatch(email);

  /// Function to validate [password].
  /// [password] must match with regex.
  bool _isPasswordValid(String password) =>
      RegExp(_passwordRegex).hasMatch(password);

  /// Function to validate [confirmPassword].
  /// Confirm password must match with [password].
  bool _isConfirmPasswordValid(String password, String confirmPassword) =>
      confirmPassword == password;
}

/// Sign up by email event.
/// Using [freezed] package.
/// Using [onEmailChange], [onPasswordChange], [onConfirmPasswordChange], [onSignUp].
@freezed
class SignUpByEmailEvent with _$SignUpByEmailEvent {
  /// Event when email change.
  /// Using [email].
  factory SignUpByEmailEvent.onEmailChange(
    String email,
  ) = _OnEmailChange;

  /// Event when password change.
  /// Using [password].
  factory SignUpByEmailEvent.onPasswordChange(
    String password,
  ) = _OnPasswordChange;

  /// Event when confirm password change.
  /// Using [confirmPassword].
  factory SignUpByEmailEvent.onConfirmPasswordChange(
    String confirmPassword,
  ) = _OnConfirmPasswordChange;

  /// Event when sign up.
  /// Using [email], [password], [confirmPassword].
  factory SignUpByEmailEvent.onSignUp(
    String email,
    String password,
    String confirmPassword,
  ) = _OnSignUp;
}

/// Sign up by email state.
@freezed
class SignUpByEmailState with _$SignUpByEmailState {
  /// State when sign up by email.
  /// Using [email], [password], [confirmPassword], [isLoading], [isSuccess], [error].
  const factory SignUpByEmailState({
    required String email,
    required String password,
    required String confirmPassword,
    required bool isLoading,
    required bool isSuccess,
    required SignUpByEmailStateError? error,
  }) = _SignUpByEmailState;

  /// Initial state.
  /// Using [email] is empty, [password] is empty, [confirmPassword] is empty, [isLoading] is false, [isSuccess] is false, [error] is null.
  factory SignUpByEmailState.initial() => const _SignUpByEmailState(
        email: "",
        password: "",
        confirmPassword: "",
        isLoading: false,
        isSuccess: false,
        error: null,
      );
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
  const factory SignUpByEmailStateError.confirmPasswordNotMatch() =
      _ConfirmPasswordNotMatch;
}
