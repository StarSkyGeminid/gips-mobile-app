import 'package:gips/core/httt_client/base_response.dart';
import 'package:gips/feature/room/model/room_model.dart';

abstract class RoomRepository {
  Future<BaseResponse<List<RoomModel>>> getRooms();
  Future<BaseResponse> joinRoom(String id, String username);
}
