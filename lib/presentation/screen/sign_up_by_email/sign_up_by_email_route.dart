import 'package:flutter/material.dart';
import 'package:heroics/di/service_locator.dart';

import 'sign_up_by_email_screen.dart';

/// Sing up by email route.
class SignUpByEmailRoute extends MaterialPageRoute {
  SignUpByEmailRoute() : super(builder: (context) => SignUpByEmailScreen(bloc: inject()));
}
