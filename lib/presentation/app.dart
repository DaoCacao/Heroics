import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'screen/enter/enter_route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Heroics",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return EnterRoute();
          default:
            return null;
        }
      },
    );
  }
}
