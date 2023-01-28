import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';
import 'package:heroics/presentation/screen/router/router_screen_provider.dart';

/// App.
class App extends StatelessWidget {
  final ThemeVariant theme;

  const App({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Heroics",
      theme: theme.when(
        defaultTheme: () {
          final systemBrightness = SchedulerBinding.instance.window.platformBrightness;
          switch (systemBrightness) {
            case Brightness.dark:
              return ThemeData.dark();
            case Brightness.light:
              return ThemeData.light();
          }
        },
        darkTheme: () => ThemeData.dark(),
        lightTheme: () => ThemeData.light(),
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
      home: const RouterScreenProvider(),
    );
  }
}
