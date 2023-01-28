import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/data/repository/auth_repository.dart';

part 'sign_up_by_email_use_case.freezed.dart';

/// Sign up by email use case.
/// This use case is used to handle sign up by email.
/// This use case will return [SignUpByEmailResult].
class SignUpByEmailUseCase {
  final AuthRepository authRepository;

  SignUpByEmailUseCase(this.authRepository);

  Future<SignUpByEmailResult> call(String email, String password) =>
      authRepository.signUpByEmail(email, password);
}

/// Sign up by email result.
@freezed
class SignUpByEmailResult with _$SignUpByEmailResult {
  /// Sign up by email success.
  factory SignUpByEmailResult.success() = _Success;

  /// Sign up by email failure.
  /// Using [SignUpByEmailResultError] when sign up by email failure.
  factory SignUpByEmailResult.failure(SignUpByEmailResultError error) = _Failure;
}

/// Sign up by email result error.
@freezed
class SignUpByEmailResultError with _$SignUpByEmailResultError {
  /// Email is already in use.
  const factory SignUpByEmailResultError.alreadyInUse() = _AlreadyInUse;

  /// Email is invalid.
  const factory SignUpByEmailResultError.invalidEmail() = _InvalidEmail;

  /// Password is weak.
  const factory SignUpByEmailResultError.weakPassword() = _WeakPassword;
}
