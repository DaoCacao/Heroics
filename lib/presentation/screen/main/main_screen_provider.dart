import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/domain/bloc/main/main_bloc.dart';
import 'package:heroics/presentation/screen/main/main_screen.dart';
import 'package:heroics/presentation/screen/settings/settings_route.dart';

/// Main screen provider.
/// Connects the bloc to the screen.
class MainScreenProvider extends StatelessWidget {
  const MainScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return MainScreen(
            page: state.page,
            onSettingsClick: () => _onSettingsClick(context),
            onPageChange: (page) => _onPageChange(context, page),
          );
        },
      ),
    );
  }

  void _onSettingsClick(BuildContext context) => Navigator.push(context, SettingsRoute());

  void _onPageChange(BuildContext context, MainPage page) =>
      context.read<MainBloc>().add(MainEvent.onPageChange(page));
}
