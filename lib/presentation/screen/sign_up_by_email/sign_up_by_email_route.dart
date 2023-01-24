import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/domain/bloc/sign_up_by_email/sign_up_by_email_bloc.dart';
import 'package:heroics/presentation/screen/sign_up_by_email/sign_up_by_email_screen.dart';

class SignUpByEmailRoute extends MaterialPageRoute {
  SignUpByEmailRoute()
      : super(
          builder: (context) => BlocProvider(
            create: (context) => SignUpByEmailBloc(inject()),
            child: BlocBuilder<SignUpByEmailBloc, SignUpByEmailState>(
              builder: (context, state) => SignUpByEmailScreen(
                emailController: TextEditingController(),
                emailError: state.maybeWhen(
                  alreadyInUse: () => "Email already in use",
                  invalidEmail: () => "Invalid email",
                  orElse: () => null,
                ),
                passwordController: TextEditingController(),
                passwordError: state.maybeWhen(
                  weakPassword: () => "Weak password",
                  orElse: () => null,
                ),
                confirmPasswordController: TextEditingController(),
                confirmPasswordError: null,
                onFormChange: (email, password, confirm) => context
                    .read<SignUpByEmailBloc>()
                    .add(SignUpByEmailEvent.updateForm(
                      email,
                      password,
                      confirm,
                    )),
                onSignUpClick: (email, password) => context
                    .read<SignUpByEmailBloc>()
                    .add(SignUpByEmailEvent.signUp(
                      email,
                      password,
                    )),
              ),
            ),
          ),
        );
}
