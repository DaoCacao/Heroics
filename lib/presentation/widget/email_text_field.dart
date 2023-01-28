import 'package:flutter/material.dart';

class EmailTextField extends TextFormField {
  EmailTextField({
    super.key,
    super.initialValue,
    super.controller,
    super.onChanged,
    required String label,
    String? error,
  }) : super(
          decoration: InputDecoration(
            label: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            border: const OutlineInputBorder(),
            errorText: error,
          ),
          keyboardType: TextInputType.emailAddress,
        );
}
