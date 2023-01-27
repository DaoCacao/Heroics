import 'package:flutter/material.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/presentation/screen/settings/settings_screen.dart';

class SettingsRoute extends MaterialPageRoute {
  SettingsRoute()
      : super(builder: (context) => SettingsScreen(themeBloc: inject(), authBloc: inject()));
}
