import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';
import 'package:heroics/presentation/screen/sign_up_by_email/sign_up_by_email_bloc.dart';
import 'package:mocktail/mocktail.dart';

class SignUpByEmailUseCaseMock extends Mock implements SignUpByEmailUseCase {}

void main() {
  group("SignUpByEmailBloc", () {
    late SignUpByEmailUseCase signUpByEmailUseCase;
    late SignUpByEmailBloc bloc;

    setUp(() {
      signUpByEmailUseCase = SignUpByEmailUseCaseMock();
      bloc = SignUpByEmailBloc(signUpByEmailUseCase);
    });

    tearDown(() {
      reset(signUpByEmailUseCase);
      bloc.close();
    });

    test(
      "initial state is SignUpByEmailState.initial()",
      () => expect(bloc.state, SignUpByEmailState.initial()),
    );

    blocTest(
      "onEmailChange emits new state with email and error is null",
      build: () => bloc,
      act: (bloc) => bloc.add(SignUpByEmailEvent.onEmailChange("email")),
      expect: () => [
        SignUpByEmailState.initial().copyWith(
          email: "email",
          error: null,
        )
      ],
    );

    blocTest(
      "onPasswordChange emits new state with password and error is null",
      build: () => bloc,
      act: (bloc) => bloc.add(SignUpByEmailEvent.onPasswordChange("password")),
      expect: () => [
        SignUpByEmailState.initial().copyWith(
          password: "password",
          error: null,
        )
      ],
    );

    blocTest(
      "onConfirmPasswordChange emits new state with confirmPassword and error is null",
      build: () => bloc,
      act: (bloc) => bloc
          .add(SignUpByEmailEvent.onConfirmPasswordChange("confirmPassword")),
      expect: () => [
        SignUpByEmailState.initial().copyWith(
          confirmPassword: "confirmPassword",
          error: null,
        )
      ],
    );

    blocTest(
      "onSignUp with invalid email emits new state with error invalidEmail",
      build: () => bloc,
      act: (bloc) => bloc.add(SignUpByEmailEvent.onSignUp("", "", "")),
      expect: () => [
        SignUpByEmailState.initial().copyWith(
          error: const SignUpByEmailStateError.invalidEmail(),
        )
      ],
    );

    blocTest(
      "onSignUp with invalid password emits new state with error weakPassword",
      build: () => bloc,
      act: (bloc) => bloc.add(SignUpByEmailEvent.onSignUp("test@test.test", "", "")),
      expect: () => [
        SignUpByEmailState.initial().copyWith(
          email: "test@test.test",
          error: const SignUpByEmailStateError.weakPassword(),
        )
      ],
    );

    blocTest(
      "onSignUp with invalid confirmPassword emits new state with error confirmPasswordNotMatch",
      build: () => bloc,
      act: (bloc) =>
          bloc.add(SignUpByEmailEvent.onSignUp("test@test.test", "password", "")),
      expect: () => [
        SignUpByEmailState.initial().copyWith(
          email: "test@test.test",
          password: "password",
          error: const SignUpByEmailStateError.confirmPasswordNotMatch(),
        )
      ],
    );
  });
}
