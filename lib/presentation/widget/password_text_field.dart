import 'package:flutter/material.dart';

class PasswordTextField extends TextFormField {
  PasswordTextField({
    super.key,
    super.controller,
    super.onChanged,
    required String label,
    String? error,
  }) : super(
          decoration: InputDecoration(
            label: Text(label),
            border: const OutlineInputBorder(),
            errorText: error,
          ),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
        );
}
