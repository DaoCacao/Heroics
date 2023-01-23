import 'package:firebase_auth/firebase_auth.dart';
import 'package:heroics/mapper/user_mapper.dart';
import 'package:heroics/use_case/sign_in_by_email_use_case.dart';
import 'package:heroics/use_case/sign_up_as_guest_use_case.dart';
import 'package:heroics/use_case/sign_up_by_email_use_case.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepository(this.firebaseAuth);

  bool isAuthorized() => firebaseAuth.currentUser != null;

  Future<SignUpAsGuestResult> signUpAsGuest() async {
    final credentials = await firebaseAuth.signInAnonymously();
    final user = mapUser(credentials.user!);
    return SignUpAsGuestResultSuccess(user);
  }

  Future<SignUpByEmailResult> signUpByEmail(
    String email,
    String password,
  ) async {
    try {
      final credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = mapUser(credentials.user!);
      return SignUpByEmailResultSuccess(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return SignUpByEmailResultAlreadyInUse();
        case "invalid-email":
          return SignUpByEmailResultInvalidEmail();
        case "weak-password":
          return SignUpByEmailResultWeakPassword();
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
      final credentials = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = mapUser(credentials.user!);
      return SignInByEmailResultSuccess(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return SignInByEmailResultInvalidEmail();
        case "user-disabled":
          return SignInByEmailResultUserNotFound();
        case "user-not-found":
          return SignInByEmailResultUserNotFound();
        case "wrong-password":
          return SignInByEmailResultWrongPassword();
        default:
          rethrow;
      }
    }
  }

  Future logout() => firebaseAuth.signOut();
}
