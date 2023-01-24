import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';
import 'package:heroics/main.dart';

part 'sign_up_by_email_cubit.freezed.dart';

class SignUpByEmailCubit extends Cubit<SignUpByEmailState> {
  final SignUpByEmailUseCase _signUpByEmailUseCase;

  SignUpByEmailCubit(
    this._signUpByEmailUseCase,
  ) : super(SignUpByEmailState.initial());

  void onFormChange(String email, String password, String confirm) async {
    log.d("Form change {$email $password $confirm}");
  }

  void onSignUpClick(String email, String password) async {
    emit(SignUpByEmailState.loading());
    final result = await _signUpByEmailUseCase(email, password);
    emit(
      result.when(
        success: (user) => SignUpByEmailState.authorized(),
        alreadyInUse: () => SignUpByEmailState.alreadyInUse(),
        invalidEmail: () => SignUpByEmailState.invalidEmail(),
        weakPassword: () => SignUpByEmailState.weakPassword(),
      ),
    );
  }
}

@freezed
class SignUpByEmailState with _$SignUpByEmailState {
  factory SignUpByEmailState.initial() = SignUpByEmailStateInitial;

  factory SignUpByEmailState.loading() = SignUpByEmailStateLoading;

  factory SignUpByEmailState.authorized() = SignUpByEmailStateAuthorized;

  factory SignUpByEmailState.alreadyInUse() = SignUpByEmailStateAlreadyInUse;

  factory SignUpByEmailState.invalidEmail() = SignUpByEmailStateInvalidEmail;

  factory SignUpByEmailState.weakPassword() = SignUpByEmailStateWeakPassword;
}
