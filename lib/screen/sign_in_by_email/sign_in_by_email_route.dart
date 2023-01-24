import 'package:flutter/material.dart';
import 'package:heroics/screen/sign_in_by_email/sign_in_by_email_screen.dart';

class SignInByEmailRoute extends MaterialPageRoute {
  SignInByEmailRoute()
      : super(
          builder: (context) => const SignInByEmailScreen(),
        );
}
