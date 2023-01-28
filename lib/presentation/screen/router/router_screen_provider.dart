import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/di/service_locator.dart';
import 'package:heroics/presentation/screen/enter/enter_route.dart';
import 'package:heroics/presentation/screen/main/main_router.dart';
import 'package:heroics/presentation/screen/router/router_bloc.dart';

import 'router_screen.dart';

/// Router screen provider.
class RouterScreenProvider extends StatelessWidget {
  const RouterScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RouterBloc(inject())..add(const RouterEvent.init()),
      child: BlocListener<RouterBloc, RouterState>(
        listener: (context, state) => state.when(
          initial: () => null,
          enter: () => _onEnter(context),
          main: () => _onMain(context),
        ),
        child: const RouterScreen(),
      ),
    );
  }

  void _onMain(BuildContext context) => Navigator.pushReplacement(context, MainRoute());

  void _onEnter(BuildContext context) => Navigator.pushReplacement(context, EnterRoute());
}
