import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/main.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log.d("$bloc, ${change.currentState} => ${change.nextState}");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log.d("$bloc, ${transition.event}, ${transition.currentState} => ${transition.nextState}");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.e(bloc, error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
