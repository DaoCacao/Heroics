import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  group("SignUpByEmailUseCase", () {
    late AuthRepository authRepository;
    late SignUpByEmailUseCase signUpByEmailUseCase;

    setUp(() {
      authRepository = AuthRepositoryMock();
      signUpByEmailUseCase = SignUpByEmailUseCase(authRepository);
    });

    test("call authRepository.signUp() and return its result", () async {
      final expectedResults = [
        SignUpByEmailResult.success(),
        SignUpByEmailResult.failure(const SignUpByEmailResultError.invalidEmail()),
        SignUpByEmailResult.failure(const SignUpByEmailResultError.weakPassword()),
        SignUpByEmailResult.failure(const SignUpByEmailResultError.alreadyInUse()),
      ];
      for (final expectedResult in expectedResults) {
        when(() => authRepository.signUpByEmail(any(), any()))
            .thenAnswer((_) async => expectedResult);
        final result = await signUpByEmailUseCase("email", "password");
        expect(result, expectedResult);
        verify(() => authRepository.signUpByEmail("email", "password")).called(1);
      }
    });
  });
}
