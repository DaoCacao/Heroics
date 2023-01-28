import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';
import 'package:heroics/domain/use_case/validation/validate_confirm_password_use_case.dart';
import 'package:heroics/domain/use_case/validation/validate_email_use_case.dart';
import 'package:heroics/domain/use_case/validation/validate_password_use_case.dart';
import 'package:heroics/presentation/screen/sign_up_by_email/sign_up_by_email_bloc.dart';
import 'package:mocktail/mocktail.dart';

class SignUpByEmailUseCaseMock extends Mock implements SignUpByEmailUseCase {}

class ValidateEmailUseCaseMock extends Mock implements ValidateEmailUseCase {}

class ValidatePasswordUseCaseMock extends Mock implements ValidatePasswordUseCase {}

class ValidateConfirmPasswordUseCaseMock extends Mock implements ValidateConfirmPasswordUseCase {}

void main() {
  group("SignUpByEmailBloc", () {
    late SignUpByEmailUseCase signUpByEmailUseCase;
    late ValidateEmailUseCase validateEmailUseCase;
    late ValidatePasswordUseCase validatePasswordUseCase;
    late ValidateConfirmPasswordUseCase validateConfirmPasswordUseCase;
    late SignUpByEmailBloc bloc;

    setUp(() {
      bloc = SignUpByEmailBloc(
        signUpByEmailUseCase = SignUpByEmailUseCaseMock(),
        validateEmailUseCase = ValidateEmailUseCaseMock(),
        validatePasswordUseCase = ValidatePasswordUseCaseMock(),
        validateConfirmPasswordUseCase = ValidateConfirmPasswordUseCaseMock(),
      );
    });

    tearDown(() {
      resetMocktailState();
      bloc.close();
    });

    test(
      "initial state is idle()",
      () => expect(bloc.state, const SignUpByEmailState.idle()),
    );

    group("onEmailChange()", () {
      blocTest(
        "emit idle() "
        "when state is not loading()",
        build: () => bloc,
        act: (bloc) => bloc.add(const SignUpByEmailEvent.onEmailChange("")),
        expect: () => [const SignUpByEmailState.idle()],
      );
      blocTest(
        "emit nothing "
        "when state is loading()",
        build: () => bloc,
        seed: () => const SignUpByEmailState.loading(),
        act: (bloc) => bloc.add(const SignUpByEmailEvent.onEmailChange("")),
        expect: () => [],
      );
    });

    group("onPasswordChange()", () {
      blocTest(
        "emit idle() "
        "when state is not loading()",
        build: () => bloc,
        act: (bloc) => bloc.add(const SignUpByEmailEvent.onPasswordChange("")),
        expect: () => [const SignUpByEmailState.idle()],
      );
      blocTest(
        "emit nothing "
        "when state is loading()",
        build: () => bloc,
        seed: () => const SignUpByEmailState.loading(),
        act: (bloc) => bloc.add(const SignUpByEmailEvent.onPasswordChange("")),
        expect: () => [],
      );
    });

    group("onConfirmPasswordChange()", () {
      blocTest(
        "emit idle() "
        "when state is not loading()",
        build: () => bloc,
        act: (bloc) => bloc.add(const SignUpByEmailEvent.onConfirmPasswordChange("")),
        expect: () => [const SignUpByEmailState.idle()],
      );
      blocTest(
        "emit nothing "
        "when state is loading()",
        build: () => bloc,
        seed: () => const SignUpByEmailState.loading(),
        act: (bloc) => bloc.add(const SignUpByEmailEvent.onConfirmPasswordChange("")),
        expect: () => [],
      );
    });

    group("onSignUp()", () {
      blocTest(
        "validate email, emit failure() with invalidEmail() "
        "when email is invalid",
        build: () {
          when(() => validateEmailUseCase.call(any())).thenReturn(false);
          return bloc;
        },
        act: (bloc) => bloc.add(const SignUpByEmailEvent.onSignUp("", "", "")),
        expect: () => [
          const SignUpByEmailState.failure(SignUpByEmailStateError.invalidEmail()),
        ],
        verify: (_) {
          verify(() => validateEmailUseCase.call(any())).called(1);
        },
      );
      blocTest(
        "validate email, validate password, emit failure() with weakPassword() "
        "when password is invalid",
        build: () {
          when(() => validateEmailUseCase.call(any())).thenReturn(true);
          when(() => validatePasswordUseCase.call(any())).thenReturn(false);
          return bloc;
        },
        act: (bloc) => bloc.add(const SignUpByEmailEvent.onSignUp("", "", "")),
        expect: () => [
          const SignUpByEmailState.failure(SignUpByEmailStateError.weakPassword()),
        ],
        verify: (_) {
          verify(() => validateEmailUseCase.call(any())).called(1);
          verify(() => validatePasswordUseCase.call(any())).called(1);
        },
      );
      blocTest(
        "validate email, validate password, validate confirm password, emit failure() with confirmPasswordNotMatch() "
        "when confirm password is invalid",
        build: () {
          when(() => validateEmailUseCase.call(any())).thenReturn(true);
          when(() => validatePasswordUseCase.call(any())).thenReturn(true);
          when(() => validateConfirmPasswordUseCase.call(any(), any())).thenReturn(false);
          return bloc;
        },
        act: (bloc) => bloc.add(const SignUpByEmailEvent.onSignUp("", "", "")),
        expect: () => [
          const SignUpByEmailState.failure(SignUpByEmailStateError.confirmPasswordNotMatch()),
        ],
        verify: (_) {
          verify(() => validateEmailUseCase.call(any())).called(1);
          verify(() => validatePasswordUseCase.call(any())).called(1);
          verify(() => validateConfirmPasswordUseCase.call(any(), any())).called(1);
        },
      );
      blocTest(
        "validate form, emit loading(), sign up, emit success() "
        "when result is success",
        build: () {
          when(() => validateEmailUseCase.call(any())).thenReturn(true);
          when(() => validatePasswordUseCase.call(any())).thenReturn(true);
          when(() => validateConfirmPasswordUseCase.call(any(), any())).thenReturn(true);
          when(() => signUpByEmailUseCase.call(any(), any()))
              .thenAnswer((_) async => SignUpByEmailResult.success());
          return bloc;
        },
        act: (bloc) => bloc.add(const SignUpByEmailEvent.onSignUp("", "", "")),
        expect: () => [
          const SignUpByEmailState.loading(),
          const SignUpByEmailState.success(),
        ],
        verify: (_) {
          verify(() => validateEmailUseCase.call(any())).called(1);
          verify(() => validatePasswordUseCase.call(any())).called(1);
          verify(() => validateConfirmPasswordUseCase.call(any(), any())).called(1);
          verify(() => signUpByEmailUseCase.call(any(), any())).called(1);
        },
      );
    });
  });
}
