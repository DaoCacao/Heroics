import 'package:flutter/material.dart';
import 'package:heroics/presentation/widget/email_text_field.dart';
import 'package:heroics/presentation/widget/password_text_field.dart';

/// Sign up by email screen implementation.
class SignUpByEmailScreenImpl extends StatelessWidget {
  final TextEditingController emailController;
  final Function(String email) onEmailChange;
  final String? emailError;

  final TextEditingController passwordController;
  final Function(String password) onPasswordChange;
  final String? passwordError;

  final TextEditingController confirmPasswordController;
  final Function(String confirm) onConfirmPasswordChange;
  final String? confirmPasswordError;

  final bool isSignUpEnable;
  final Function(String email, String password, String confirm) onSignUpClick;

  const SignUpByEmailScreenImpl({
    super.key,
    required this.emailController,
    required this.onEmailChange,
    required this.emailError,
    required this.passwordController,
    required this.onPasswordChange,
    required this.passwordError,
    required this.confirmPasswordController,
    required this.onConfirmPasswordChange,
    required this.confirmPasswordError,
    required this.isSignUpEnable,
    required this.onSignUpClick,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EmailTextField(
                label: "Email",
                controller: emailController,
                onChanged: onEmailChange,
                error: emailError,
              ),
              const SizedBox(height: 16),
              PasswordTextField(
                label: "Password",
                controller: passwordController,
                onChanged: onPasswordChange,
                error: passwordError,
              ),
              const SizedBox(height: 16),
              PasswordTextField(
                label: "Confirm password",
                controller: confirmPasswordController,
                onChanged: onConfirmPasswordChange,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: isSignUpEnable
                    ? () => onSignUpClick(
                          emailController.text,
                          passwordController.text,
                          confirmPasswordController.text,
                        )
                    : null,
                child: const Text("Sign up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
