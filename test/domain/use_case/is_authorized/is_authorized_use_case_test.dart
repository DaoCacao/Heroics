import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/domain/use_case/is_authorized/is_authorized_use_case.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  group("IsAuthorizedUseCase", () {
    late AuthRepository authRepository;
    late IsAuthorizedUseCase isAuthorizedUseCase;

    setUp(() {
      authRepository = AuthRepositoryMock();
      isAuthorizedUseCase = IsAuthorizedUseCase(authRepository);
    });

    test(
      "call authRepository.isAuthorized() and return its result",
      () async {
        final expectedResults = [true, false];
        for (final expectedResult in expectedResults) {
          when(() => authRepository.isAuthorized()).thenAnswer((_) => expectedResult);
          final result = isAuthorizedUseCase();
          expect(result, expectedResult);
          verify(() => authRepository.isAuthorized()).called(1);
        }
      },
    );
  });
}
