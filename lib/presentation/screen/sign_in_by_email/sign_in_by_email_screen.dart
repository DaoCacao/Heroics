import 'package:flutter/material.dart';

class SignInByEmailScreen extends StatelessWidget {
  const SignInByEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: TextEditingController(text: ""),
                onChanged: null,
              ),
              TextField(
                controller: TextEditingController(text: ""),
                onChanged: null,
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text("Sign in"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
