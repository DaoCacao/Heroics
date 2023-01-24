import 'package:firebase_auth/firebase_auth.dart';
import 'package:heroics/domain/model/user_model.dart';

UserModel mapUser(User user) => UserModel(
      id: user.uid,
      name: user.displayName ?? "",
    );
