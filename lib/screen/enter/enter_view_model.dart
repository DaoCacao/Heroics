import 'dart:async';

import 'package:heroics/base/view_model.dart';
import 'package:heroics/use_case/is_authorized_use_case.dart';
import 'package:heroics/use_case/sign_out_use_case.dart';
import 'package:heroics/use_case/sign_up_as_guest_use_case.dart';

class EnterViewModel extends ViewModel {
  final bool isGuest;
  final IsAuthorizedUseCase isAuthorizedUseCase;
  final SignUpAsGuestUseCase signUpAsGuestUseCase;
  final SignOutUseCase signOutUseCase;

  EnterViewModel(
    this.isAuthorizedUseCase,
    this.signUpAsGuestUseCase,
    this.signOutUseCase,
  ) {
    isGuest = isAuthorizedUseCase();
  }

  EnterViewModel.inject() : super(inject(), inject(), inject());

  void onSignInClick() {}

  void onSignUpClick() {}

  void onContinueAsGuestClick() async {
    final result = await signUpAsGuestUseCase();
    if (result is SignUpAsGuestResultSuccess) {}
  }

  void onLogoutClick() async {
    await signOutUseCase();
  }
}
