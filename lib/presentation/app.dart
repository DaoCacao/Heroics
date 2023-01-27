import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/domain/bloc/auth/auth_bloc.dart';
import 'package:heroics/domain/bloc/theme/theme_bloc.dart';
import 'package:heroics/presentation/screen/enter/enter_route.dart';
import 'package:heroics/presentation/screen/settings/settings_route.dart';

/// App.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => inject(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => AppImpl(
          theme: state.when(
            darkTheme: () => ThemeData.dark(),
            lightTheme: () => ThemeData.light(),
          ),
        ),
      ),
    );
  }
}

/// App implementation.
class AppImpl extends StatelessWidget {
  final ThemeData theme;

  const AppImpl({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Heroics",
      theme: theme,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
      home: const RouteScreen(),
    );
  }
}

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => inject()..add(AuthEvent.check()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => state.when(
          initial: () => null,
          unauthorized: () => Navigator.pushReplacement(context, EnterRoute()),
          authorized: () => Navigator.pushReplacement(context, SettingsRoute()),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
