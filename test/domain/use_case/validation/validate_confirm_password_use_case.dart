import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/domain/use_case/validation/validate_confirm_password_use_case.dart';

void main() {
  group("ValidateConfirmPasswordUseCase", () {
    late ValidateConfirmPasswordUseCase validateConfirmPasswordUseCase;

    setUp(() {
      validateConfirmPasswordUseCase = ValidateConfirmPasswordUseCase();
    });

    const validPasswords = {
      "password": "password",
      "pass": "pass",
    };
    for (final password in validPasswords.keys) {
      test(
          "return true when password '$password' and confirm password '${validPasswords[password]}' are the same",
          () {
        expect(validateConfirmPasswordUseCase(password, validPasswords[password]!), true);
      });
    }

    const invalidPasswords = {
      "password": "pass",
      "pass": "password",
    };
    for (final password in invalidPasswords.keys) {
      test(
          "return false when password '$password' and confirm password '${invalidPasswords[password]}' are not the same",
          () {
        expect(validateConfirmPasswordUseCase(password, invalidPasswords[password]!), false);
      });
    }
  });
}
