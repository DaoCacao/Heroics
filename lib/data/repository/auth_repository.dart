import 'package:firebase_auth/firebase_auth.dart';
import 'package:heroics/domain/use_case/sign_in_by_email/sign_in_by_email_use_case.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  const AuthRepository(this._firebaseAuth);

  bool isAuthorized() {
    return _firebaseAuth.currentUser != null;
  }

  Future signUpAsGuest() async {
    await _firebaseAuth.signInAnonymously();
  }

  /// Sign up by email.
  /// Using [email] and [password] to sign up.
  /// This method will return [SignUpByEmailResult].
  /// If sign up success, this method will return [SignUpByEmailResult.success].
  /// If sign up failure, this method will return [SignUpByEmailResult.failure] with [error].
  /// If email is already in use, [error] will be [SignUpByEmailResultError.alreadyInUse].
  /// If email is invalid, [error] will be [SignUpByEmailResultError.invalidEmail].
  /// If password is weak, [error] will be [SignUpByEmailResultError.weakPassword].
  Future<SignUpByEmailResult> signUpByEmail(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SignUpByEmailResult.success();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return SignUpByEmailResult.failure(
            const SignUpByEmailResultError.alreadyInUse(),
          );
        case "invalid-email":
          return SignUpByEmailResult.failure(
            const SignUpByEmailResultError.invalidEmail(),
          );
        case "weak-password":
          return SignUpByEmailResult.failure(
            const SignUpByEmailResultError.weakPassword(),
          );
        default:
          rethrow;
      }
    }
  }

  Future<SignInByEmailResult> signInByEmail(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const SignInByEmailResult.success();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return const SignInByEmailResult.failure(
            SignInByEmailResultError.invalidEmail(),
          );
        case "user-disabled":
          return const SignInByEmailResult.failure(
            SignInByEmailResultError.userNotFound(),
          );
        case "user-not-found":
          return const SignInByEmailResult.failure(
            SignInByEmailResultError.userNotFound(),
          );
        case "wrong-password":
          return const SignInByEmailResult.failure(
            SignInByEmailResultError.wrongPassword(),
          );
        default:
          rethrow;
      }
    }
  }

  Future signOut() => _firebaseAuth.signOut();
}
