import 'package:flutter/material.dart';
import 'package:heroics/screen/main/main_screen.dart';

class MainRouter extends MaterialPageRoute {
  MainRouter()
      : super(
          builder: (context) => const MainScreen(),
        );
}
