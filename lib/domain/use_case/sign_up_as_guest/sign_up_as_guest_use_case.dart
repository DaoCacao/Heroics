import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/model/user_model.dart';

class SignUpAsGuestUseCase {
  final AuthRepository authRepository;

  SignUpAsGuestUseCase(this.authRepository);

  Future<ProfileModel> call() {
    return authRepository.signUpAsGuest();
  }
}