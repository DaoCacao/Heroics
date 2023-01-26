import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/app_firebase_provider.dart';
import 'package:heroics/di/app_local_storage_provider.dart';
import 'package:heroics/di/app_repository_provider.dart';
import 'package:heroics/di/app_use_case_provider.dart';
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

  _initFirebase();
  Bloc.observer = AppBlocObserver();

  runApp(
    AppLocalStorageProvider(
      sharedPreferences: await SharedPreferences.getInstance(),
      child: AppFirebaseProvider(
        child: AppRepositoryProvider(
          child: AppUseCaseProvider(
            child: const App(),
          ),
        ),
      ),
    ),
  );
}

/// Initialize Firebase services.
void _initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  /// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  /// Change the default fetch timeout and minimum fetch interval for debug mode.
  if (kDebugMode) {
    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
  }
  await FirebaseRemoteConfig.instance.fetchAndActivate();
}
