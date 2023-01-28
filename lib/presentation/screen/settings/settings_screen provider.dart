import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';
import 'package:heroics/presentation/screen/settings/settings_bloc.dart';

import 'settings_screen.dart';

/// Settings screen provider.
class SettingsScreenProvider extends StatelessWidget {
  const SettingsScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SettingsBloc(inject(), inject(), inject())..add(const SettingsEvent.init()),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) => SettingsScreen(
          theme: state.maybeWhen(
            idle: (theme) => theme,
            orElse: () => const ThemeVariant.defaultTheme(),
          ),
          onThemeChange: (theme) => _onThemeChange(context, theme),
          onSignOutClick: () => _onSignOutClick(context),
        ),
      ),
    );
  }

  void _onThemeChange(BuildContext context, ThemeVariant theme) =>
      context.read<SettingsBloc>().add(SettingsEvent.changeTheme(theme));

  void _onSignOutClick(BuildContext context) =>
      context.read<SettingsBloc>().add(const SettingsEvent.signOut());
}
