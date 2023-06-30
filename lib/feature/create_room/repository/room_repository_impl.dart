import 'package:dio/dio.dart';
import 'package:gips/feature/create_room/repository/room_repository.dart';
import 'package:gips/feature/room/model/room_model.dart';
import 'package:gips/core/httt_client/base_response.dart';

import '../model/settings_model.dart';

class CreateRoomRepositoryImpl extends CreateRoomRepository {
  final Dio client;

  CreateRoomRepositoryImpl({required this.client});

  @override
  Future<BaseResponse<RoomModel>> createRoom(
      SettingsModel settingsModel) async {
    try {
      final result = await client.post("create-room",
          queryParameters: settingsModel.toJson());
      return BaseResponse.fromJson(result.data, (json) {
        return RoomModel.fromJson(json as Map<String, dynamic>);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<List<String>>> getTheme() async {
    try {
      final result = await client.get("list-theme");
      return BaseResponse.fromJson(result.data, (json) {
        List data = json as List;
        return data.map((e) => e.toString()).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponse> joinRoom(String id, String username) async {
    try {
      final result = await client.post(
        "game/$id/join",
        queryParameters: {
          "username": username,
        },
      );
      return BaseResponse.fromJson(result.data, (json) {
        return null;
      });
    } catch (e) {
      rethrow;
    }
  }
}
