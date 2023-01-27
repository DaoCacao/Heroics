/// Validate email use case.
class ValidateEmailUseCase {
  /// Regex to validate email.
  static const String _emailRegex = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  /// Function to validate [email].
  /// [email] must be not empty and match with regex.
  bool call(String email) =>
      email.isNotEmpty && RegExp(_emailRegex).hasMatch(email);
}
