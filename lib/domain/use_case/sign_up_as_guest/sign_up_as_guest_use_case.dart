import 'package:heroics/data/repository/auth_repository.dart';

class SignUpAsGuestUseCase {
  final AuthRepository authRepository;

  SignUpAsGuestUseCase(this.authRepository);

  Future call() => authRepository.signUpAsGuest();
}
