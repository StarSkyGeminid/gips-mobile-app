import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gips/core/bloc/status/bloc_status.dart';
import 'package:gips/feature/create_room/model/settings_model.dart';
import 'package:gips/feature/create_room/repository/room_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_room_state.dart';
part 'create_room_cubit.freezed.dart';

class CreateRoomCubit extends Cubit<CreateRoomState> {
  final CreateRoomRepository repo;
  CreateRoomCubit({
    required this.repo,
  }) : super(const CreateRoomState());

  void getThemes() async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      final result = await repo.getTheme();
      if (result.status == 200) {
        emit(state.copyWith(
          status: BlocStatus.initial,
          themes: result.data ?? [],
          settings: state.settings.copyWith(theme: result.data?.first ?? ""),
        ));
      } else {
        emit(state.copyWith(status: BlocStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  void setTotalPlayer(int value) {
    emit(state.copyWith(status: BlocStatus.loading));

    emit(state.copyWith(
      settings: state.settings.copyWith(maxPlayer: value),
      status: BlocStatus.initial,
    ));
  }

  void setTotalRound(int value) {
    emit(state.copyWith(
      settings: state.settings.copyWith(maxRound: value),
      status: BlocStatus.initial,
    ));
  }

  void setTheme(String value) {
    emit(state.copyWith(
      settings: state.settings.copyWith(theme: value),
      status: BlocStatus.initial,
    ));
  }

  void createRoom(String username) async {
    emit(state.copyWith(createStatus: BlocStatus.loading));

    try {
      final result = await repo.createRoom(state.settings);
      if (result.status == 200 && result.data != null) {
        emit(state.copyWith(
          settings: state.settings.copyWith(id: result.data!.id!),
          createStatus: BlocStatus.initial,
        ));
        _joinRoom(result.data!.id!, username);
      } else {
        emit(state.copyWith(createStatus: BlocStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(createStatus: BlocStatus.error));
    }
  }

  void _joinRoom(String id, String username) async {
    emit(state.copyWith(joinStatus: BlocStatus.loading));

    try {
      final result = await repo.joinRoom(id, username);
      if (result.status == 200) {
        emit(state.copyWith(
          joinStatus: BlocStatus.success,
          errorMessage: null,
        ));
      } else {
        emit(state.copyWith(
          joinStatus: BlocStatus.error,
          errorMessage: result.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        joinStatus: BlocStatus.error,
        errorMessage: "Terjadi kesalahan, harap coba lagi!",
      ));
    } finally {
      emit(state.copyWith(joinStatus: BlocStatus.initial));
    }
  }
}
