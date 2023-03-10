import 'package:flutter/material.dart';

class EnterScreen extends StatelessWidget {
  final bool isLoading;
  final Function() onSignUpClick;
  final Function() onSignInClick;
  final Function() onSignUpAsGuestClick;

  const EnterScreen({
    super.key,
    required this.isLoading,
    required this.onSignUpClick,
    required this.onSignInClick,
    required this.onSignUpAsGuestClick,
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => onSignUpClick(),
                child: const Text("Sign up with email"),
              ),
              ElevatedButton(
                onPressed: onSignInClick,
                child: const Text("Sign in with email"),
              ),
              ElevatedButton(
                onPressed: isLoading ? null : onSignUpAsGuestClick,
                child: const Text("Continue as guest"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
