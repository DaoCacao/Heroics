import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    required String name,
    required bool isGuest,
  }) = _ProfileModel;
}
