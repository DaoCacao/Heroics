/// Validate password use case.
class ValidatePasswordUseCase {
  /// Regex to validate password.
  /// Must contains at least 6 characters.
  /// Can contains any symbols.
  static const String _passwordRegex = r"^.{6,}$";

  /// Function to validate [password].
  /// [password] must be not empty and match with regex.
  bool call(String password) => password.isNotEmpty && RegExp(_passwordRegex).hasMatch(password);
}
