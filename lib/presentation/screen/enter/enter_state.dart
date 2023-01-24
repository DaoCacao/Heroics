import 'package:freezed_annotation/freezed_annotation.dart';

part 'enter_state.freezed.dart';

@freezed
class EnterState with _$EnterState {
  factory EnterState.initial() = EnterStateInitial;

  factory EnterState.loading() = EnterStateLoading;

  factory EnterState.authorized() = EnterStateAuthorized;
}
