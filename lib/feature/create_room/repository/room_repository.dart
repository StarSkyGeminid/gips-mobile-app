import 'package:gips/core/httt_client/base_response.dart';
import 'package:gips/feature/room/model/room_model.dart';

import '../model/settings_model.dart';

abstract class CreateRoomRepository {
  Future<BaseResponse<RoomModel>> createRoom(SettingsModel settingsModel);
  Future<BaseResponse<List<String>>> getTheme();
  Future<BaseResponse> joinRoom(String id, String username);
}
