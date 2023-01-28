import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heroics/domain/use_case/is_authorized/is_authorized_use_case.dart';

part 'router_bloc.freezed.dart';

/// Router bloc.
/// This bloc will emit [RouterState] when state is changed.
/// This bloc will handle [RouterEvent] when event is added.
class RouterBloc extends Bloc<RouterEvent, RouterState> {
  final IsAuthorizedUseCase _isAuthorizedUseCase;

  RouterBloc(this._isAuthorizedUseCase) : super(const RouterState.initial()) {
    on<RouterEvent>((event, emit) => event.map(
          init: (event) => _init(event, emit),
        ));
  }

  /// Function to handle [RouterEvent.init].
  /// Check authorization state.
  /// If user is authorized, emit [RouterState.main].
  /// If user is not authorized, emit [RouterState.enter].
  void _init(_Init event, Emitter<RouterState> emit) {
    final isAuthorized = _isAuthorizedUseCase();
    if (isAuthorized) {
      emit(const RouterState.main());
    } else {
      emit(const RouterState.enter());
    }
  }
}

/// Router event.
@freezed
class RouterEvent with _$RouterEvent {
  /// Navigate to home screen.
  const factory RouterEvent.init() = _Init;
}

/// Router state.
@freezed
class RouterState with _$RouterState {
  /// Initial state.
  const factory RouterState.initial() = _Initial;

  /// Main screen state.
  const factory RouterState.main() = _Main;

  /// Enter screen state.
  const factory RouterState.enter() = _Enter;
}
