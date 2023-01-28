import 'package:flutter/material.dart';
import 'package:heroics/domain/model/theme/theme_variants.dart';

/// Settings screen.
class SettingsScreen extends StatelessWidget {
  final ThemeVariant theme;
  final void Function(ThemeVariant) onThemeChange;
  final void Function() onSignOutClick;

  const SettingsScreen({
    super.key,
    required this.theme,
    required this.onThemeChange,
    required this.onSignOutClick,
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
            title: const Text("App theme"),
            trailing: DropdownButton<ThemeVariant>(
              value: theme,
              onChanged: (value) => onThemeChange(value!),
              items: const [
                DropdownMenuItem(
                  value: ThemeVariant.defaultTheme(),
                  child: Text("System"),
                ),
                DropdownMenuItem(
                  value: ThemeVariant.lightTheme(),
                  child: Text("Light"),
                ),
                DropdownMenuItem(
                  value: ThemeVariant.darkTheme(),
                  child: Text("Dark"),
                ),
              ],
            ),
          ),
          const Spacer(),
          SafeArea(
            child: TextButton(
              onPressed: onSignOutClick,
              child: const Text("Sign out"),
            ),
          ),
        ],
      ),
    );
  }
}
