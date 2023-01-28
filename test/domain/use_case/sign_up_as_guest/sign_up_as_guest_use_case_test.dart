import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/use_case/sign_up_as_guest/sign_up_as_guest_use_case.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  group("SignUpAsGuestUseCase", () {
    late AuthRepository authRepository;
    late SignUpAsGuestUseCase signUpAsGuestUseCase;

    setUp(() {
      authRepository = AuthRepositoryMock();
      signUpAsGuestUseCase = SignUpAsGuestUseCase(authRepository);
    });

    test(
      "call authRepository.signUpAsGuest() and return nothing",
      () async {
        when(() => authRepository.signUpAsGuest()).thenAnswer((_) async => null);
        await signUpAsGuestUseCase();
        verify(() => authRepository.signUpAsGuest()).called(1);
      },
    );
  });
}
