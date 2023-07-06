part of 'create_room_cubit.dart';

@freezed
class CreateRoomState with _$CreateRoomState {
  const factory CreateRoomState({
    @Default(BlocStatus.initial) BlocStatus status,
    @Default(BlocStatus.initial) BlocStatus createStatus,
    @Default(BlocStatus.initial) BlocStatus joinStatus,
    @Default(SettingsModel.empty) SettingsModel settings,
    @Default([]) List<String> themes,
    String? errorMessage,
    @Default(30) int selectedTimer,
  }) = _CreateRoomState;
}
