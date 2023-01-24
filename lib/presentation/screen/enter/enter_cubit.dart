import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/domain/use_case/is_authorized_use_case.dart';
import 'package:heroics/domain/use_case/sign_up_as_guest_use_case.dart';
import 'package:heroics/presentation/screen/enter/enter_state.dart';

class EnterCubit extends Cubit<EnterState> {
  final IsAuthorizedUseCase isAuthorizedUseCase;
  final SignUpAsGuestUseCase signUpAsGuestUseCase;

  EnterCubit(
    this.isAuthorizedUseCase,
    this.signUpAsGuestUseCase,
  ) : super(EnterState.initial());

  void signUpAsGuest() async {
    emit(EnterState.loading());
    final result = await signUpAsGuestUseCase();
    if (result is SignUpAsGuestResultSuccess) {
      emit(EnterState.authorized());
    }
  }
}

class EnterCubitProvider extends BlocProvider<EnterCubit> {
  EnterCubitProvider({super.key, super.child})
      : super(create: (_) => EnterCubit(inject(), inject()));
}
