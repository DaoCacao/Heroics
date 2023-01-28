import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_bloc.freezed.dart';

/// Main bloc.
/// This bloc will handle [MainEvent] when event is added.
/// This bloc will emit [MainState] when state is changed.
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState.idle(MainPage.home())) {
    on<MainEvent>((event, emit) => event.map(
          onPageChange: (event) => _onPageChange(event, emit),
        ));
  }

  /// Function to handle [MainEvent.onPageChange].
  void _onPageChange(_OnPageChange event, Emitter<MainState> emit) {
    emit(MainState.idle(event.page));
  }
}

/// MainEvent.
@freezed
class MainEvent with _$MainEvent {
  const factory MainEvent.onPageChange(MainPage page) = _OnPageChange;
}

/// MainState.
@freezed
class MainState with _$MainState {
  /// Idle state.
  const factory MainState.idle(MainPage page) = _Idle;
}

@freezed
class MainPage with _$MainPage {
  const factory MainPage.home() = _Home;

  const factory MainPage.profile() = _Profile;

  const factory MainPage.library() = _Library;
}
