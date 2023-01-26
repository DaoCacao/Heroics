import 'package:flutter/material.dart';

class EmailTextField extends TextFormField {
  EmailTextField({
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
          keyboardType: TextInputType.emailAddress,
        );
}
