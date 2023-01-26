import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/model/profile_model.dart';

part 'sign_up_by_email_use_case.freezed.dart';

/// Sign up by email use case.
/// This use case is used to handle sign up by email.
/// This use case will return [SignUpByEmailResult].
class SignUpByEmailUseCase {
  final AuthRepository authRepository;

  SignUpByEmailUseCase(this.authRepository);

  Future<SignUpByEmailResult> call({
    required String email,
    required String password,
  }) async {
    return authRepository.signUpByEmail(email, password);
  }
}

/// Sign up by email result.
@freezed
class SignUpByEmailResult with _$SignUpByEmailResult {
  /// Sign up by email success.
  /// This result will return [ProfileModel] when sign up by email success.
  factory SignUpByEmailResult.success(ProfileModel user) = _Success;

  /// Sign up by email failure.
  /// This result will return [SignUpByEmailResultError] when sign up by email failure.
  /// This result will return [SignUpByEmailResultError.alreadyInUse] when email is already in use.
  /// This result will return [SignUpByEmailResultError.invalidEmail] when email is invalid.
  /// This result will return [SignUpByEmailResultError.weakPassword] when password is weak.
  factory SignUpByEmailResult.failure(SignUpByEmailResultError error) =
      _Failure;
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
