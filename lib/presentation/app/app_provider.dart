import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';

import 'app.dart';
import 'app_bloc.dart';

/// App provider.
class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(inject(), inject())..add(const AppEvent.init()),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) => App(
          theme: state.maybeWhen(
            idle: (theme) => theme,
            orElse: () => const ThemeVariant.defaultTheme(),
          ),
        ),
      ),
    );
  }
}
