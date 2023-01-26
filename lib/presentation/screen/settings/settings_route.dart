import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/domain/bloc/auth/auth_bloc.dart';
import 'package:heroics/presentation/screen/settings/settings_screen.dart';

class SettingsRoute extends MaterialPageRoute {
  SettingsRoute()
      : super(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AuthBloc(context.read())),
            ],
            child: const SettingsScreen(),
          ),
        );
}
