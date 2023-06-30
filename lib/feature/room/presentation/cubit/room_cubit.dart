import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gips/core/bloc/status/bloc_status.dart';
import 'package:gips/feature/room/model/room_model.dart';
import 'package:gips/feature/room/repository/room_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_state.dart';
part 'room_cubit.freezed.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomRepository repo;
  RoomCubit({
    required this.repo,
  }) : super(const RoomState());

  void getRooms() async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      final result = await repo.getRooms();
      if (result.status == 200) {
        emit(state.copyWith(
          status: BlocStatus.success,
          rooms: result.data ?? [],
        ));
      } else {
        emit(state.copyWith(status: BlocStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  void joinRoom(String id, String username) async {
    emit(state.copyWith(joinStatus: BlocStatus.loading));

    try {
      final result = await repo.joinRoom(id, username);
      if (result.status == 200) {
        emit(state.copyWith(
          joinStatus: BlocStatus.success,
          roomId: id,
          errorMessage: null,
        ));
      } else {
        emit(state.copyWith(
          joinStatus: BlocStatus.error,
          roomId: null,
          errorMessage: result.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        joinStatus: BlocStatus.error,
        roomId: null,
        errorMessage: "Terjadi kesalahan, harap coba lagi!",
      ));
    } finally {
      emit(state.copyWith(joinStatus: BlocStatus.initial));
    }
  }
}
