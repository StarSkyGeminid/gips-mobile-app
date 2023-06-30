// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel<T> _$RoomModelFromJson<T>(Map<String, dynamic> json) => RoomModel<T>(
      id: json['id'] as String?,
      totalPlayer: json['totalPlayers'] as int? ?? 0,
      maxPlayer: json['maxPlayers'] as int? ?? 0,
    );

Map<String, dynamic> _$RoomModelToJson<T>(RoomModel<T> instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalPlayers': instance.totalPlayer,
      'maxPlayers': instance.maxPlayer,
    };
