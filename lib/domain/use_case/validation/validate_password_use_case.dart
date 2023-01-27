/// Validate password use case.
class ValidatePasswordUseCase {
  /// Regex to validate password.
  static const String _passwordRegex = r"^[a-zA-Z0-9]{6,}$";

  /// Function to validate [password].
  /// [password] must be not empty and match with regex.
  bool call(String password) =>
      password.isNotEmpty && RegExp(_passwordRegex).hasMatch(password);
}