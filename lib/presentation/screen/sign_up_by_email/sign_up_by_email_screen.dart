import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/presentation/screen/settings/settings_route.dart';
import 'package:heroics/presentation/screen/sign_up_by_email/sign_up_by_email_bloc.dart';

import 'sign_up_by_email_screen_impl.dart';

/// Sign up by email screen.
/// This screen is used to sign up by email.
class SignUpByEmailScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  SignUpByEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpByEmailBloc(context.read()),
      child: BlocConsumer<SignUpByEmailBloc, SignUpByEmailState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushAndRemoveUntil(
                context, SettingsRoute(), (route) => false);
          }
        },
        builder: (context, state) => SignUpByEmailScreenImpl(
          emailController: _emailController,
          onEmailChange: (email) => context
              .read<SignUpByEmailBloc>()
              .add(SignUpByEmailEvent.onEmailChange(email)),
          emailError: state.error?.whenOrNull(
            alreadyInUse: () => "Email already in use",
            invalidEmail: () => "Invalid email",
          ),
          passwordController: _passwordController,
          onPasswordChange: (password) => context
              .read<SignUpByEmailBloc>()
              .add(SignUpByEmailEvent.onPasswordChange(password)),
          passwordError: state.error?.whenOrNull(
            weakPassword: () => "Weak password",
          ),
          confirmPasswordController: _confirmPasswordController,
          onConfirmPasswordChange: (confirm) => context
              .read<SignUpByEmailBloc>()
              .add(SignUpByEmailEvent.onConfirmPasswordChange(confirm)),
          confirmPasswordError: state.error?.whenOrNull(
            confirmPasswordNotMatch: () => "Password not match",
          ),
          isSignUpEnable: !state.isLoading,
          onSignUpClick: (email, password, confirm) =>
              context.read<SignUpByEmailBloc>().add(SignUpByEmailEvent.onSignUp(
                    email,
                    password,
                    confirm,
                  )),
        ),
      ),
    );
  }
}
