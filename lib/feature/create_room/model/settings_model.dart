import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
   @Default('') String id,
   @Default('') String theme,
   @Default(25) int maxPlayer,
   @Default(10) int maxRound,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  static const empty = SettingsModel(
    id: '',
    theme: '',
    maxPlayer: 25,
    maxRound: 10,
  );
}
