import 'package:heroics/repository/auth_repository.dart';
import 'package:heroics/use_case/sign_up_by_email/sign_up_by_email_result.dart';

class SignUpByEmailUseCase {
  final AuthRepository authRepository;

  SignUpByEmailUseCase(this.authRepository);

  Future<SignUpByEmailResult> call(String email, String password) {
    return authRepository.signUpByEmail(email, password);
  }
}
