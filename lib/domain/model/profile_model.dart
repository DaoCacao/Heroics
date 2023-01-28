import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required this.id,
    required this.name,
    required this.isGuest,
  }) = _ProfileModel;
}
