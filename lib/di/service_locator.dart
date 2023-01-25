import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/data/repository/theme_repository.dart';
import 'package:heroics/data/shared_preferences/shared_preferences.dart';
import 'package:heroics/domain/use_case/is_authorized/is_authorized_use_case.dart';
import 'package:heroics/domain/use_case/sign_in_by_email/sign_in_by_email_use_case.dart';
import 'package:heroics/domain/use_case/sign_out/sign_out_use_case.dart';
import 'package:heroics/domain/use_case/sign_up_as_guest/sign_up_as_guest_use_case.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

void initServiceLocator({
  required SharedPreferences sharedPreferences,
}) {
  GetIt.instance
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => sharedPreferences)
    ..registerLazySingleton(() => AppSharedPreferences(inject()))
    ..registerLazySingleton(() => AuthRepository(inject()))
    ..registerLazySingleton(() => ThemeRepository(inject()))
    ..registerFactory(() => IsAuthorizedUseCase(inject()))
    ..registerFactory(() => SignOutUseCase(inject()))
    ..registerFactory(() => SignInByEmailUseCase(inject()))
    ..registerFactory(() => SignUpAsGuestUseCase(inject()))
    ..registerFactory(() => SignUpByEmailUseCase(inject()));
}

T inject<T extends Object>() => GetIt.instance.get();
