import 'package:flutter/material.dart';
import 'package:heroics/base/view_model_provider.dart';

import 'enter_screen.dart';
import 'enter_view_model.dart';

class EnterRoute extends MaterialPageRoute<EnterScreen> {
  EnterRoute()
      : super(
          builder: (context) => ViewModelProvider(
            create: () => EnterViewModel.inject(),
            builder: (viewModel) => EnterScreen(
              onSignUpClick: viewModel.onSignUpClick,
              onSignInClick: viewModel.onSignInClick,
              onContinueAsGuestClick: viewModel.onContinueAsGuestClick,
            ),
          ),
        );
}
