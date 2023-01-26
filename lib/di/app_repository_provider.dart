import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/data/repository/theme_repository.dart';

/// App repository provider.
/// This widget will provide all Repositories to its descendants.
class AppRepositoryProvider extends MultiRepositoryProvider {
  AppRepositoryProvider({
    super.key,
    required super.child,
  }) : super(
          providers: [
            RepositoryProvider(
                create: (context) => AuthRepository(context.read())),
            RepositoryProvider(
                create: (context) => ThemeRepository(context.read())),
          ],
        );
}
