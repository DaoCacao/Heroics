import 'package:flutter/material.dart';

class EnterScreen extends StatelessWidget {
  final bool isLoading;
  final bool isAuthorized;
  final VoidCallback onSignUpClick;
  final VoidCallback onSignInClick;
  final VoidCallback onSignUpAsGuestClick;
  final VoidCallback onSignOutClick;

  const EnterScreen({
    super.key,
    required this.isLoading,
    required this.isAuthorized,
    required this.onSignUpClick,
    required this.onSignInClick,
    required this.onSignUpAsGuestClick,
    required this.onSignOutClick,
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
            if (isAuthorized) ...[
              const Text(
                "Authorized as guest",
              ),
              ElevatedButton(
                onPressed: isLoading ? null : onSignOutClick,
                child: const Text("Sign out"),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: isLoading ? null : onSignUpClick,
                child: const Text("Sign up with email"),
              ),
              ElevatedButton(
                onPressed: isLoading ? null : onSignInClick,
                child: const Text("Sign in with email"),
              ),
              ElevatedButton(
                onPressed: isLoading ? null : onSignUpAsGuestClick,
                child: const Text("Continue as guest"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
