import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/model/profile/profile_model.dart';

part 'sign_in_by_email_use_case.freezed.dart';

/// Sign in by email use case.
class SignInByEmailUseCase {
  final AuthRepository authRepository;

  SignInByEmailUseCase(this.authRepository);

  /// Sign in by email.
  Future<SignInByEmailResult> call(String email, String password) =>
      authRepository.signInByEmail(email, password);
}

/// Sign in by email result.
@freezed
class SignInByEmailResult with _$SignInByEmailResult {
  /// Success.
  const factory SignInByEmailResult.success() = _Success;

  /// Failure.
  /// Using [SignInByEmailResultError] when sign in by email failure.
  const factory SignInByEmailResult.failure(SignInByEmailResultError error) = _Failure;
}

/// Sign in by email result error.
@freezed
class SignInByEmailResultError with _$SignInByEmailResultError {
  /// User not found.
  const factory SignInByEmailResultError.userNotFound() = _UserNotFound;

  /// Invalid email.
  const factory SignInByEmailResultError.invalidEmail() = _InvalidEmail;

  /// Wrong password.
  const factory SignInByEmailResultError.wrongPassword() = _WrongPassword;
}
