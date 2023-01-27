/// Validate confirm password use case.
class ValidateConfirmPasswordUseCase {
  /// Function to validate [confirmPassword].
  /// [password] and [confirmPassword] must be the same.
  bool call(String password, String confirmPassword) => password == confirmPassword;
}
