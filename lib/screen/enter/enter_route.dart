import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'enter_cubit.dart';
import 'enter_screen.dart';

class EnterRoute extends MaterialPageRoute<EnterScreen> {
  EnterRoute()
      : super(
          builder: (context) => BlocProvider(
            create: (context) => EnterCubit.inject(),
            child: BlocBuilder<EnterCubit, EnterState>(
              builder: (context, state) {
                final bloc = context.watch<EnterCubit>();
                return EnterScreen(
                  isLoading: state.isLoading,
                  isAuthorized: state.isAuthorized,
                  onSignUpClick: bloc.onSignUpClick,
                  onSignInClick: bloc.onSignInClick,
                  onSignUpAsGuestClick: bloc.onSignUpAsGuestClick,
                  onSignOutClick: bloc.onSignOutClick,
                );
              },
            ),
          ),
        );
}
