import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/model/user_model.dart';

part 'sign_up_by_email_result.freezed.dart';

@freezed
class SignUpByEmailResult with _$SignUpByEmailResult {
  factory SignUpByEmailResult.success(UserModel user) = _Success;

  factory SignUpByEmailResult.alreadyInUse() = _AlreadyInUse;

  factory SignUpByEmailResult.invalidEmail() = _InvalidEmail;

  factory SignUpByEmailResult.weakPassword() = _WeakPassword;
}
