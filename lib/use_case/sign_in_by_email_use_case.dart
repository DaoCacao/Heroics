import 'package:heroics/model/user_model.dart';
import 'package:heroics/repository/auth_repository.dart';

class SignInByEmailUseCase {
  final AuthRepository authRepository;

  SignInByEmailUseCase(this.authRepository);

  Future<SignInByEmailResult> call(String email, String password) {
    return authRepository.signInByEmail(email, password);
  }
}

abstract class SignInByEmailResult {}

class SignInByEmailResultSuccess extends SignInByEmailResult {
  final UserModel user;

  SignInByEmailResultSuccess(this.user);
}

class SignInByEmailResultUserNotFound extends SignInByEmailResult {}

class SignInByEmailResultInvalidEmail extends SignInByEmailResult {}

class SignInByEmailResultWrongPassword extends SignInByEmailResult {}
