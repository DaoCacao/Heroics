import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/domain/bloc/auth/auth_bloc.dart';
import 'package:heroics/domain/bloc/theme/theme_bloc.dart';
import 'package:heroics/firebase_options.dart';
import 'package:heroics/logger/app_bloc_observer.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logger/logger.dart';
import 'presentation/app.dart';

final log = Log(
  logger: Logger(
    printer: SimplePrinter(),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EquatableConfig.stringify = true;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (kDebugMode) {
    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
  }
  await FirebaseRemoteConfig.instance.fetchAndActivate();

  Bloc.observer = AppBlocObserver();

  initServiceLocator(
    sharedPreferences: await SharedPreferences.getInstance(),
  );
  runApp(const App());
}
