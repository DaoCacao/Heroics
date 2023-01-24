import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/model/profile_model.dart';

part 'sign_in_by_email_use_case.freezed.dart';

class SignInByEmailUseCase {
  final AuthRepository authRepository;

  SignInByEmailUseCase(this.authRepository);

  Future<SignInByEmailResult> call(String email, String password) {
    return authRepository.signInByEmail(email, password);
  }
}

@freezed
class SignInByEmailResult with _$SignInByEmailResult {
  factory SignInByEmailResult.success(ProfileModel user) = _Success;

  factory SignInByEmailResult.userNotFound() = _UserNotFound;

  factory SignInByEmailResult.invalidEmail() = _InvalidEmail;

  factory SignInByEmailResult.wrongPassword() = _WrongPassword;
}
