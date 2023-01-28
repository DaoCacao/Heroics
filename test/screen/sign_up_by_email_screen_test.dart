import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/presentation/screen/sign_up_by_email/sign_up_by_email_screen.dart';

Widget _createWidgetForTesting({
  String? title,
  String? email,
  String? emailError,
  String? password,
  String? passwordError,
  String? confirmPassword,
  String? confirmPasswordError,
  bool? isSignUpEnable,
}) {
  return MaterialApp(
    home: SignUpByEmailScreen(
      title: title ?? "Title",
      emailController: TextEditingController(text: email),
      onEmailChange: (String email) {},
      emailError: emailError,
      passwordController: TextEditingController(text: password),
      onPasswordChange: (String password) {},
      passwordError: passwordError,
      confirmPasswordController: TextEditingController(text: confirmPassword),
      onConfirmPasswordChange: (String confirmPassword) {},
      confirmPasswordError: confirmPasswordError,
      isSignUpEnable: isSignUpEnable ?? true,
      onSignUpClick: () {},
    ),
  );
}

void main() {
  group("SignUpByEmailScreen", () {
    group("should display", () {
      testWidgets("title", (widgetTester) async {
        await widgetTester.pumpWidget(_createWidgetForTesting(title: "Test title"));
        final title = find.text("Test title");
        expect(title, findsOneWidget);
      });
      testWidgets("email text field", (widgetTester) async {
        await widgetTester.pumpWidget(_createWidgetForTesting(email: "Test text"));
        final emailTextField = find.text("Test text");
        expect(emailTextField, findsOneWidget);
      });
      testWidgets("password text field", (widgetTester) async {
        await widgetTester.pumpWidget(_createWidgetForTesting(password: "Test text"));
        final passwordTextField = find.text("Test text");
        expect(passwordTextField, findsOneWidget);
      });
      testWidgets("confirm password text field", (widgetTester) async {
        await widgetTester.pumpWidget(_createWidgetForTesting(confirmPassword: "Test text"));
        final confirmPasswordTextField = find.text("Test text");
        expect(confirmPasswordTextField, findsOneWidget);
      });
    });
  });
}
