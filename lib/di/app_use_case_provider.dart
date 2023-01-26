import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/domain/use_case/is_authorized/is_authorized_use_case.dart';
import 'package:heroics/domain/use_case/sign_in_by_email/sign_in_by_email_use_case.dart';
import 'package:heroics/domain/use_case/sign_out/sign_out_use_case.dart';
import 'package:heroics/domain/use_case/sign_up_as_guest/sign_up_as_guest_use_case.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';

/// Use case repository provider.
class AppUseCaseProvider extends MultiRepositoryProvider {
  AppUseCaseProvider({
    super.key,
    required super.child,
  }) : super(providers: [
          RepositoryProvider(
            create: (context) => IsAuthorizedUseCase(context.read()),
          ),
          RepositoryProvider(
            create: (context) => SignInByEmailUseCase(context.read()),
          ),
          RepositoryProvider(
            create: (context) => SignOutUseCase(context.read()),
          ),
          RepositoryProvider(
            create: (context) => SignUpAsGuestUseCase(context.read()),
          ),
          RepositoryProvider(
            create: (context) => SignUpByEmailUseCase(context.read()),
          ),
        ]);
}
