import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/model/user_model.dart';

part 'sign_up_by_email_use_case.freezed.dart';

class SignUpByEmailUseCase {
  final AuthRepository authRepository;

  SignUpByEmailUseCase(this.authRepository);

  Future<SignUpByEmailResult> call(String email, String password) {
    return authRepository.signUpByEmail(email, password);
  }
}

@freezed
class SignUpByEmailResult with _$SignUpByEmailResult {
  factory SignUpByEmailResult.success(UserModel user) = _Success;

  factory SignUpByEmailResult.alreadyInUse() = _AlreadyInUse;

  factory SignUpByEmailResult.invalidEmail() = _InvalidEmail;

  factory SignUpByEmailResult.weakPassword() = _WeakPassword;
}
