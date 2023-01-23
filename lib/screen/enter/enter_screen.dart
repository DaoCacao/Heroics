import 'package:flutter/material.dart';

class EnterScreen extends StatelessWidget {
  final bool isGuest;
  final Function onSignUpClick;
  final Function onSignInClick;
  final Function onContinueAsGuestClick;

  const EnterScreen({
    super.key,
    required this.isGuest,
    required this.onSignUpClick,
    required this.onSignInClick,
    required this.onContinueAsGuestClick,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Enter",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: onSignUpClick,
              child: const Text("Sign up with email"),
            ),
            ElevatedButton(
              onPressed: onSignInClick,
              child: const Text("Sign in with email"),
            ),
            ElevatedButton(
              onPressed: onContinueAsGuestClick,
              child: const Text("Continue as guest"),
            ),
          ],
        ),
      ),
    );
  }
}
