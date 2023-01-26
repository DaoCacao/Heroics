import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Firebase provider
/// This widget will provide all Firebase services to its descendants.
class AppFirebaseProvider extends MultiRepositoryProvider {
  AppFirebaseProvider({
    super.key,
    required super.child,
  }) : super(
          providers: [
            RepositoryProvider(create: (context) => FirebaseAuth.instance),
            RepositoryProvider(create: (context) => FirebaseCrashlytics.instance),
            RepositoryProvider(create: (context) => FirebaseRemoteConfig.instance),
          ],
        );
}
