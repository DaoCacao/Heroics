import 'package:heroics/repository/auth_repository.dart';

class IsAuthorizedUseCase {
  final AuthRepository authRepository;

  IsAuthorizedUseCase(this.authRepository);

  bool call() {
    return authRepository.isAuthorized();
  }
}
