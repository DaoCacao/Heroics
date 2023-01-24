import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/domain/bloc/sign_up_by_email/sign_up_by_email_bloc.dart'
    as bloc;
import 'package:heroics/domain/cubit/sign_up_by_email/sign_up_by_email_cubit.dart'
    as cubit;
import 'package:heroics/presentation/screen/sign_up_by_email/sign_up_by_email_screen.dart';

class SignUpByEmailRoute extends MaterialPageRoute {
  SignUpByEmailRoute.cubit()
      : super(
            builder: (context) => BlocProvider(
                  create: (context) => cubit.SignUpByEmailCubit(inject()),
                  child: BlocBuilder<cubit.SignUpByEmailCubit,
                      cubit.SignUpByEmailState>(
                    builder: (context, state) => SignUpByEmailScreen(
                      emailController: TextEditingController(),
                      emailError: state.maybeWhen(
                        alreadyInUse: () => "Email already in use",
                        invalidEmail: () => "Invalid email",
                        orElse: () => null,
                      ),
                      passwordController: TextEditingController(),
                      passwordError: state.maybeWhen(
                        weakPassword: () => "Weak password",
                        orElse: () => null,
                      ),
                      confirmPasswordController: TextEditingController(),
                      confirmPasswordError: null,
                      onFormChange: (email, password, confirm) => context
                          .read<cubit.SignUpByEmailCubit>()
                          .onFormChange(email, password, confirm),
                      onSignUpClick: (email, password) => context
                          .read<cubit.SignUpByEmailCubit>()
                          .onSignUpClick(email, password),
                    ),
                  ),
                ));

  SignUpByEmailRoute.bloc()
      : super(
          builder: (context) => BlocProvider(
            create: (context) => bloc.SignUpByEmailBloc(inject()),
            child: BlocBuilder<bloc.SignUpByEmailBloc, bloc.SignUpByEmailState>(
              builder: (context, state) => SignUpByEmailScreen(
                emailController: TextEditingController(),
                emailError: state.maybeWhen(
                  alreadyInUse: () => "Email already in use",
                  invalidEmail: () => "Invalid email",
                  orElse: () => null,
                ),
                passwordController: TextEditingController(),
                passwordError: state.maybeWhen(
                  weakPassword: () => "Weak password",
                  orElse: () => null,
                ),
                confirmPasswordController: TextEditingController(),
                confirmPasswordError: null,
                onFormChange: (email, password, confirm) => context
                    .read<bloc.SignUpByEmailBloc>()
                    .add(bloc.SignUpByEmailEvent.updateForm(
                      email,
                      password,
                      confirm,
                    )),
                onSignUpClick: (email, password) => context
                    .read<bloc.SignUpByEmailBloc>()
                    .add(bloc.SignUpByEmailEvent.signUp(
                      email,
                      password,
                    )),
              ),
            ),
          ),
        );
}
