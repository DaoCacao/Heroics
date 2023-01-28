import 'package:heroics/data/repository/auth_repository.dart';

class IsAuthorizedUseCase {
  final AuthRepository authRepository;

  IsAuthorizedUseCase(this.authRepository);

  bool call() => authRepository.isAuthorized();
}
