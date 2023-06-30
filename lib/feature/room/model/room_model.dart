import 'package:freezed_annotation/freezed_annotation.dart';
part 'room_model.g.dart';

@JsonSerializable()
class RoomModel<T> {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'totalPlayers')
  int? totalPlayer;
  @JsonKey(name: 'maxPlayers')
  int? maxPlayer;

  RoomModel({
    this.id,
    this.totalPlayer = 0,
    this.maxPlayer = 0,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
