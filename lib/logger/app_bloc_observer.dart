import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroics/main.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.d("${bloc.runtimeType} ${change.currentState} => ${change.nextState}");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log.d("${bloc.runtimeType} $event");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log.e(bloc.runtimeType, error, stackTrace);
  }
}
