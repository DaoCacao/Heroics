import 'package:firebase_auth/firebase_auth.dart';
import 'package:heroics/data/mapper/user_mapper.dart';
import 'package:heroics/domain/model/user_model.dart';
import 'package:heroics/domain/use_case/sign_in_by_email/sign_in_by_email_use_case.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;

  const AuthRepository(this.firebaseAuth);

  bool isAuthorized() {
    return firebaseAuth.currentUser != null;
  }

  Future<ProfileModel> signUpAsGuest() async {
    final credentials = await firebaseAuth.signInAnonymously();
    final user = mapProfile(credentials.user!);
    return user;
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
      final user = mapProfile(credentials.user!);
      return SignUpByEmailResult.success(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return SignUpByEmailResult.alreadyInUse();
        case "invalid-email":
          return SignUpByEmailResult.invalidEmail();
        case "weak-password":
          return SignUpByEmailResult.weakPassword();
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
      final user = mapProfile(credentials.user!);
      return SignInByEmailResult.success(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return SignInByEmailResult.invalidEmail();
        case "user-disabled":
          return SignInByEmailResult.userNotFound();
        case "user-not-found":
          return SignInByEmailResult.userNotFound();
        case "wrong-password":
          return SignInByEmailResult.wrongPassword();
        default:
          rethrow;
      }
    }
  }

  Future logout() => firebaseAuth.signOut();
}
