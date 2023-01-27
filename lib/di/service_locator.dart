import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:heroics/data/repository/auth_repository.dart';
import 'package:heroics/data/repository/theme_repository.dart';
import 'package:heroics/data/shared_preferences/shared_preferences.dart';
import 'package:heroics/domain/bloc/auth/auth_bloc.dart';
import 'package:heroics/domain/bloc/theme/theme_bloc.dart';
import 'package:heroics/domain/use_case/is_authorized/is_authorized_use_case.dart';
import 'package:heroics/domain/use_case/sign_in_by_email/sign_in_by_email_use_case.dart';
import 'package:heroics/domain/use_case/sign_out/sign_out_use_case.dart';
import 'package:heroics/domain/use_case/sign_up_as_guest/sign_up_as_guest_use_case.dart';
import 'package:heroics/domain/use_case/sign_up_by_email/sign_up_by_email_use_case.dart';
import 'package:heroics/domain/use_case/validation/validate_confirm_password_use_case.dart';
import 'package:heroics/domain/use_case/validation/validate_email_use_case.dart';
import 'package:heroics/domain/use_case/validation/validate_password_use_case.dart';
import 'package:heroics/presentation/screen/enter/enter_cubit.dart';
import 'package:heroics/presentation/screen/sign_up_by_email/sign_up_by_email_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future setupDependencies() async {
  final getIt = GetIt.instance;
  await _setupPreferences(getIt);
  await _setupFirebase(getIt);
  await _setupRepository(getIt);
  await _setupUseCase(getIt);
  await _setupBloc(getIt);
}

Future _setupPreferences(GetIt getIt) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => AppSharedPreferences(inject()));
}

Future _setupFirebase(GetIt getIt) async {
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseCrashlytics.instance);
  getIt.registerLazySingleton(() => FirebaseRemoteConfig.instance);
}

Future _setupRepository(GetIt getIt) async {
  getIt.registerLazySingleton(() => AuthRepository(inject()));
  getIt.registerLazySingleton(() => ThemeRepository(inject()));
}

Future _setupUseCase(GetIt getIt) async {
  getIt.registerFactory(() => IsAuthorizedUseCase(inject()));
  getIt.registerFactory(() => SignInByEmailUseCase(inject()));
  getIt.registerFactory(() => SignOutUseCase(inject()));
  getIt.registerFactory(() => SignUpAsGuestUseCase(inject()));
  getIt.registerFactory(() => SignUpByEmailUseCase(inject()));
  getIt.registerFactory(() => ValidateEmailUseCase());
  getIt.registerFactory(() => ValidatePasswordUseCase());
  getIt.registerFactory(() => ValidateConfirmPasswordUseCase());
}

Future _setupBloc(GetIt getIt) async {
  getIt.registerFactory(() => AuthBloc(inject()));
  getIt.registerFactory(() => ThemeBloc(inject()));
  getIt.registerFactory(() => EnterCubit(inject(), inject()));
  getIt.registerFactory(() => SignUpByEmailBloc(inject(), inject(), inject(), inject()));
}

T inject<T extends Object>() => GetIt.instance.get();
