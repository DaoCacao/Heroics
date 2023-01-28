import 'package:flutter_test/flutter_test.dart';
import 'package:heroics/domain/use_case/validation/validate_email_use_case.dart';

void main() {
  group("ValidateEmailUseCase", () {
    late ValidateEmailUseCase validateEmailUseCase;
    const validEmails = [
      "test@test.test",
      "underscore_email@some.domain",
      "plus+email@some.domain",
      "number123@some.domain",
      "CAPS@EMAIL.COM",
    ];
    const invalidEmails = [
      "",
      "without_at",
      "@without_name",
      "without@domain",
      "coma@email,here",
    ];

    setUp(() {
      validateEmailUseCase = ValidateEmailUseCase();
    });

    for (final validEmail in validEmails) {
      test("return true when email '$validEmail' is valid", () {
        expect(validateEmailUseCase(validEmail), true);
      });
    }

    for (final invalidEmail in invalidEmails) {
      test("return false when email $invalidEmail is invalid", () {
        expect(validateEmailUseCase(invalidEmail), false);
      });
    }
  });
}
