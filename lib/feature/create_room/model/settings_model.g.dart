// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SettingsModel _$$_SettingsModelFromJson(Map<String, dynamic> json) =>
    _$_SettingsModel(
      id: json['id'] as String? ?? '',
      theme: json['theme'] as String? ?? '',
      maxPlayer: json['maxPlayer'] as int? ?? 25,
      maxRound: json['maxRound'] as int? ?? 10,
    );

Map<String, dynamic> _$$_SettingsModelToJson(_$_SettingsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'theme': instance.theme,
      'maxPlayer': instance.maxPlayer,
      'maxRound': instance.maxRound,
    };
