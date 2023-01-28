import 'package:heroics/data/repository/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase(this.authRepository);

  Future call() => authRepository.signOut();
}
