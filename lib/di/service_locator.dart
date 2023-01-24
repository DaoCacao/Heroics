import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:heroics/repository/auth_repository.dart';
import 'package:heroics/use_case/is_authorized_use_case.dart';
import 'package:heroics/use_case/sign_in_by_email_use_case.dart';
import 'package:heroics/use_case/sign_out_use_case.dart';
import 'package:heroics/use_case/sign_up_as_guest_use_case.dart';
import 'package:heroics/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';

void initServiceLocator() {
  GetIt.instance
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => AuthRepository(inject()))
    ..registerFactory(() => IsAuthorizedUseCase(inject()))
    ..registerFactory(() => SignOutUseCase(inject()))
    ..registerFactory(() => SignInByEmailUseCase(inject()))
    ..registerFactory(() => SignUpAsGuestUseCase(inject()))
    ..registerFactory(() => SignUpByEmailUseCase(inject()));
}

T inject<T extends Object>() => GetIt.instance.get();
