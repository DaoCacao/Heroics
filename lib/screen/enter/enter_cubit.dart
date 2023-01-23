import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/use_case/is_authorized_use_case.dart';
import 'package:heroics/use_case/sign_out_use_case.dart';
import 'package:heroics/use_case/sign_up_as_guest_use_case.dart';

class EnterCubit extends Cubit<EnterState> {
  final IsAuthorizedUseCase isAuthorizedUseCase;
  final SignUpAsGuestUseCase signUpAsGuestUseCase;
  final SignOutUseCase signOutUseCase;

  EnterCubit(
    this.isAuthorizedUseCase,
    this.signUpAsGuestUseCase,
    this.signOutUseCase,
  ) : super(EnterState(
          isAuthorized: isAuthorizedUseCase(),
          isLoading: false,
        ));

  EnterCubit.inject() : this(inject(), inject(), inject());

  void onSignInClick() {
    // emit(state.copy(isLoading: true));
    // emit(state.copy(
    //   isAuthorized: true,
    //   isLoading: false,
    // ));
  }

  void onSignUpClick() {
    // emit(state.copy(isLoading: true));
    // emit(state.copy(
    //   isAuthorized: true,
    //   isLoading: false,
    // ));
  }

  void onSignUpAsGuestClick() async {
    emit(state.copy(
      isLoading: true,
    ));
    final result = await signUpAsGuestUseCase();
    if (result is SignUpAsGuestResultSuccess) {
      emit(state.copy(
        isAuthorized: true,
        isLoading: false,
      ));
    }
  }

  void onSignOutClick() async {
    emit(state.copy(
      isLoading: true,
    ));
    await signOutUseCase();
    emit(state.copy(
      isAuthorized: false,
      isLoading: false,
    ));
  }
}

class EnterState extends Equatable {
  final bool isAuthorized;
  final bool isLoading;

  const EnterState({
    this.isAuthorized = false,
    this.isLoading = false,
  });

  EnterState copy({
    bool? isAuthorized,
    bool? isLoading,
  }) =>
      EnterState(
        isAuthorized: isAuthorized ?? this.isAuthorized,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [isAuthorized, isLoading];
}
