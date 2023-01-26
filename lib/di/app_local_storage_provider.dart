import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/data/shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local storage provider.
/// This widget will provide all LocalStorages to its descendants.
class AppLocalStorageProvider extends MultiRepositoryProvider {
  AppLocalStorageProvider({
    super.key,
    required SharedPreferences sharedPreferences,
    required super.child,
  }) : super(
          providers: [
            RepositoryProvider(
              create: (context) => AppSharedPreferences(sharedPreferences),
            ),
          ],
        );
}
