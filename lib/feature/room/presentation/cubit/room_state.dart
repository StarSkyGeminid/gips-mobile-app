part of 'room_cubit.dart';

@freezed
class RoomState with _$RoomState {
  const factory RoomState({
    @Default(BlocStatus.initial) BlocStatus status,
    @Default([]) List<RoomModel> rooms,
    @Default(BlocStatus.initial) BlocStatus joinStatus,
    String? roomId,
    @Default(60) int duration,
    String? errorMessage,
  }) = _RoomState;
}
