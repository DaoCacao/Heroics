import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/presentation/screen/main/main_router.dart';
import 'package:heroics/presentation/screen/sign_up_by_email/sign_up_by_email_bloc.dart';

import 'sign_up_by_email_screen_impl.dart';

/// Sign up by email screen.
/// This screen is used to sign up by email.
class SignUpByEmailScreen extends StatelessWidget {
  final SignUpByEmailBloc bloc;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  SignUpByEmailScreen({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpByEmailBloc, SignUpByEmailState>(
      bloc: bloc,
      listener: (context, state) => state.whenOrNull(
        success: () => Navigator.pushAndRemoveUntil(context, MainRoute(), (route) => false),
      ),
      builder: (context, state) => SignUpByEmailScreenImpl(
        emailController: _emailController,
        onEmailChange: _onEmailChange,
        emailError: state.whenOrNull(
          failure: (error) => error.whenOrNull(
            alreadyInUse: () => "Email already in use",
            invalidEmail: () => "Invalid email",
          ),
        ),
        passwordController: _passwordController,
        onPasswordChange: _onPasswordChange,
        passwordError: state.whenOrNull(
          failure: (error) => error.whenOrNull(
            weakPassword: () => "Weak password",
          ),
        ),
        confirmPasswordController: _confirmPasswordController,
        onConfirmPasswordChange: _onConfirmPasswordChange,
        confirmPasswordError: state.whenOrNull(
          failure: (error) => error.whenOrNull(
            confirmPasswordNotMatch: () => "Password not match",
          ),
        ),
        isSignUpEnable: state.maybeWhen(
          loading: () => false,
          orElse: () => true,
        ),
        onSignUpClick: _onSignUpClick,
      ),
    );
  }

  void _onEmailChange(String email) => bloc.add(SignUpByEmailEvent.onEmailChange(email));

  void _onPasswordChange(String password) =>
      bloc.add(SignUpByEmailEvent.onPasswordChange(password));

  void _onConfirmPasswordChange(String confirm) =>
      bloc.add(SignUpByEmailEvent.onConfirmPasswordChange(confirm));

  void _onSignUpClick(String email, String password, String confirm) =>
      bloc.add(SignUpByEmailEvent.onSignUp(email, password, confirm));
}
