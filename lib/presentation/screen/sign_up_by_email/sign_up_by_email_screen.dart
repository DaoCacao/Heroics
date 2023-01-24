import 'package:flutter/material.dart';
import 'package:heroics/presentation/widget/email_text_field.dart';
import 'package:heroics/presentation/widget/password_text_field.dart';

class SignUpByEmailScreen extends StatelessWidget {
  final TextEditingController emailController;
  final String? emailError;

  final TextEditingController passwordController;
  final String? passwordError;

  final TextEditingController confirmPasswordController;
  final String? confirmPasswordError;

  final Function(String email, String password, String confirm) onFormChange;
  final Function(String email, String password) onSignUpClick;

  const SignUpByEmailScreen({
    super.key,
    required this.emailController,
    required this.emailError,
    required this.passwordController,
    required this.passwordError,
    required this.confirmPasswordController,
    required this.confirmPasswordError,
    required this.onFormChange,
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
          child: Form(
            onChanged: () => onFormChange(
              emailController.text,
              passwordController.text,
              confirmPasswordController.text,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EmailTextField(
                  controller: emailController,
                  label: "Email",
                  error: emailError,
                ),
                const SizedBox(height: 16),
                PasswordTextField(
                  controller: passwordController,
                  label: "Password",
                  error: passwordError,
                ),
                const SizedBox(height: 16),
                PasswordTextField(
                  controller: confirmPasswordController,
                  label: "Confirm password",
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => onSignUpClick(
                    emailController.text,
                    passwordController.text,
                  ),
                  child: const Text("Sign up"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
