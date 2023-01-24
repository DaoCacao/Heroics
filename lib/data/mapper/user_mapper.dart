import 'package:firebase_auth/firebase_auth.dart';
import 'package:heroics/domain/model/user_model.dart';

ProfileModel mapProfile(User user) => ProfileModel(
      id: user.uid,
      name: user.displayName ?? "",
      isGuest: user.isAnonymous,
    );
