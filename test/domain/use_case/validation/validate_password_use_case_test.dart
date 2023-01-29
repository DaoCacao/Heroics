import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/domain/use_case/validation/validate_password_use_case.dart';

void main() {
  group("ValidatePasswordUseCase", () {
    late ValidatePasswordUseCase validatePasswordUseCase;

    setUp(() {
      validatePasswordUseCase = ValidatePasswordUseCase();
    });

    const validPasswords = [
      "123456",
      "letters",
      "with_underscore",
      "CAPSLETTERS",
      "!@#\$%^&*()_+",
    ];
    for (final validPassword in validPasswords) {
      test("return true when password '$validPassword' is valid", () {
        expect(validatePasswordUseCase(validPassword), true);
      });
    }

    const invalidPasswords = [
      "",
      "less6",
    ];
    for (final invalidPassword in invalidPasswords) {
      test("return false when password '$invalidPassword' is invalid", () {
        expect(validatePasswordUseCase(invalidPassword), false);
      });
    }
  });
}
