import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/use_case/sign_out/sign_out_use_case.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  group("SignOutUseCase", () {
    late AuthRepository authRepository;
    late SignOutUseCase signOutUseCase;

    setUp(() {
      authRepository = AuthRepositoryMock();
      signOutUseCase = SignOutUseCase(authRepository);
    });

    tearDown(() {
      resetMocktailState();
    });

    test(
      "call authRepository.signOut()",
      () async {
        when(() => authRepository.signOut()).thenAnswer((_) async => null);
        await signOutUseCase();
        verify(() => authRepository.signOut()).called(1);
      },
    );
  });
}
