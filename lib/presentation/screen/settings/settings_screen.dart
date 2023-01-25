import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/domain/bloc/auth/auth_bloc.dart';
import 'package:heroics/domain/bloc/theme/theme_bloc.dart';
import 'package:heroics/presentation/screen/enter/enter_route.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Dark theme"),
            trailing: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) => Switch(
                value: state.when(
                  darkTheme: () => true,
                  lightTheme: () => false,
                ),
                onChanged: (value) => context
                    .read<ThemeBloc>()
                    .add(ThemeEvent.switchTheme(value)),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) => state.when(
                initial: () => null,
                authorized: () => null,
                unauthorized: () => Navigator.pushAndRemoveUntil(
                  context,
                  EnterRoute(),
                  (route) => false,
                ),
              ),
              child: TextButton(
                onPressed: () =>
                    context.read<AuthBloc>().add(AuthEvent.signOut()),
                child: const Text("Sign out"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
