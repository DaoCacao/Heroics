import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
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
    return BlocProvider<SignUpByEmailBloc>(
      create: (context) => inject(),
      child: BlocConsumer<SignUpByEmailBloc, SignUpByEmailState>(
        listener: (context, state) => state.whenOrNull(
          success: () => Navigator.pushAndRemoveUntil(context, SettingsRoute(), (route) => false),
        ),
        builder: (context, state) => SignUpByEmailScreenImpl(
          emailController: _emailController,
          onEmailChange: (email) => _onEmailChange(context, email),
          emailError: state.whenOrNull(
            failure: (error) => error.whenOrNull(
              alreadyInUse: () => "Email already in use",
              invalidEmail: () => "Invalid email",
            ),
          ),
          passwordController: _passwordController,
          onPasswordChange: (password) => _onPasswordChange(context, password),
          passwordError: state.whenOrNull(
            failure: (error) => error.whenOrNull(
              weakPassword: () => "Weak password",
            ),
          ),
          confirmPasswordController: _confirmPasswordController,
          onConfirmPasswordChange: (confirm) => _onConfirmPasswordChange(context, confirm),
          confirmPasswordError: state.whenOrNull(
            failure: (error) => error.whenOrNull(
              confirmPasswordNotMatch: () => "Password not match",
            ),
          ),
          isSignUpEnable: state.maybeWhen(
            loading: () => false,
            orElse: () => true,
          ),
          onSignUpClick: (email, password, confirm) =>
              _onSignUpClick(context, email, password, confirm),
        ),
      ),
    );
  }

  void _onEmailChange(BuildContext context, String email) {
    context.read<SignUpByEmailBloc>().add(SignUpByEmailEvent.onEmailChange(email));
  }

  void _onPasswordChange(BuildContext context, String password) {
    context.read<SignUpByEmailBloc>().add(SignUpByEmailEvent.onPasswordChange(password));
  }

  void _onConfirmPasswordChange(BuildContext context, String confirm) {
    context.read<SignUpByEmailBloc>().add(SignUpByEmailEvent.onConfirmPasswordChange(confirm));
  }

  void _onSignUpClick(BuildContext context, String email, String password, String confirm) {
    context.read<SignUpByEmailBloc>().add(SignUpByEmailEvent.onSignUp(email, password, confirm));
  }
}
