import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/model/user_model.dart';

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
