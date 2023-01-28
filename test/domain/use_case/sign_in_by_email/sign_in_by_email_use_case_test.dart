import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/use_case/sign_in_by_email/sign_in_by_email_use_case.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  group("SignInByEmailUseCase", () {
    late AuthRepository authRepository;
    late SignInByEmailUseCase signInByEmailUseCase;

    setUp(() {
      authRepository = AuthRepositoryMock();
      signInByEmailUseCase = SignInByEmailUseCase(authRepository);
    });

    test(
      "call authRepository.signInByEmail() and return its result",
      () async {
        final expectedResults = [
          const SignInByEmailResult.success(),
          const SignInByEmailResult.failure(SignInByEmailResultError.userNotFound()),
          const SignInByEmailResult.failure(SignInByEmailResultError.invalidEmail()),
          const SignInByEmailResult.failure(SignInByEmailResultError.wrongPassword()),
        ];
        for (final expectedResult in expectedResults) {
          when(() => authRepository.signInByEmail(any(), any()))
              .thenAnswer((_) async => expectedResult);
          final result = await signInByEmailUseCase("email", "password");
          expect(result, expectedResult);
          verify(() => authRepository.signInByEmail("email", "password")).called(1);
        }
      },
    );
  });
}
