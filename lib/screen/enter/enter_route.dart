import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/screen/enter/enter_state.dart';
import 'package:heroics/screen/main/main_router.dart';
import 'package:heroics/screen/sign_in_by_email/sign_in_by_email_route.dart';
import 'package:heroics/screen/sign_up_by_email/sign_up_by_email_route.dart';

import 'enter_cubit.dart';
import 'enter_screen.dart';

class EnterRoute extends MaterialPageRoute {
  EnterRoute()
      : super(
          builder: (context) => EnterCubitProvider(
            child: BlocConsumer<EnterCubit, EnterState>(
              listener: (context, state) {
                state.when(
                    initial: () {},
                    loading: () {},
                    authorized: () {
                      Navigator.pushReplacement(context, MainRouter());
                    });
              },
              builder: (context, state) {
                return EnterScreen(
                  isLoading: state is EnterStateLoading,
                  onSignUpClick: (isCubit) =>
                      Navigator.push(context, isCubit ? SignUpByEmailRoute.cubit() : SignUpByEmailRoute.bloc()),
                  onSignInClick: () =>
                      Navigator.push(context, SignInByEmailRoute()),
                  onSignUpAsGuestClick: () =>
                      context.read<EnterCubit>().signUpAsGuest(),
                );
              },
            ),
          ),
        );
}
