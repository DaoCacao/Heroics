import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/domain/bloc/auth/auth_bloc.dart';
import 'package:heroics/domain/bloc/theme/theme_bloc.dart';
import 'package:heroics/presentation/screen/enter/enter_route.dart';
import 'package:heroics/presentation/screen/settings/settings_route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(inject()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => MaterialApp(
          title: "Heroics",
          theme: state.when(
            darkTheme: () => ThemeData.dark(),
            lightTheme: () => ThemeData.light(),
          ),
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
          ],
          home: const RouteScreen(),
        ),
      ),
    );
  }
}

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(inject())..add(AuthEvent.check()),
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
