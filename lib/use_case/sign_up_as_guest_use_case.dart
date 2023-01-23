import 'package:heroics/model/user_model.dart';
import 'package:heroics/repository/auth_repository.dart';

class SignUpAsGuestUseCase {
  final AuthRepository authRepository;

  SignUpAsGuestUseCase(this.authRepository);

  Future<SignUpAsGuestResult> call() {
    return authRepository.signUpAsGuest();
  }
}

abstract class SignUpAsGuestResult {}

class SignUpAsGuestResultSuccess extends SignUpAsGuestResult {
  final UserModel user;

  SignUpAsGuestResultSuccess(this.user);
}
