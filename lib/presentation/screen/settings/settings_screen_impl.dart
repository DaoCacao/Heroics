import 'package:flutter/material.dart';

class SettingsScreenImpl extends StatelessWidget {
  final bool isDarkTheme;
  final Function(bool) onThemeChanged;
  final Function() onSignOut;

  const SettingsScreenImpl({
    super.key,
    required this.isDarkTheme,
    required this.onThemeChanged,
    required this.onSignOut,
  });

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
            trailing: Switch(
              value: isDarkTheme,
              onChanged: onThemeChanged,
            ),
          ),
          const Spacer(),
          SafeArea(
            child: TextButton(
              onPressed: onSignOut,
              child: const Text("Sign out"),
            ),
          ),
        ],
      ),
    );
  }
}
