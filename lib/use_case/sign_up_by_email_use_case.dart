import 'package:heroics/model/user_model.dart';
import 'package:heroics/repository/auth_repository.dart';

class SignUpByEmailUseCase {
  final AuthRepository authRepository;

  SignUpByEmailUseCase(this.authRepository);

  Future<SignUpByEmailResult> call(String email, String password) {
    return authRepository.signUpByEmail(email, password);
  }
}

abstract class SignUpByEmailResult {}

class SignUpByEmailResultSuccess extends SignUpByEmailResult {
  final UserModel user;

  SignUpByEmailResultSuccess(this.user);
}

class SignUpByEmailResultAlreadyInUse extends SignUpByEmailResult {}

class SignUpByEmailResultInvalidEmail extends SignUpByEmailResult {}

class SignUpByEmailResultWeakPassword extends SignUpByEmailResult {}
