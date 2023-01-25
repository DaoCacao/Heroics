import 'package:flutter/material.dart';
import 'package:heroics/presentation/screen/main/main_screen.dart';

class MainRoute extends MaterialPageRoute {
  MainRoute()
      : super(
          builder: (context) => const MainScreen(),
        );
}
