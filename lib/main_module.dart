import 'package:dio/dio.dart';
import 'package:gips/core/httt_client/http_client.dart';
import 'package:gips/feature/create_room/repository/room_repository.dart';
import 'package:gips/feature/create_room/repository/room_repository_impl.dart';
import 'package:gips/feature/room/repository/room_repository.dart';
import 'package:gips/feature/room/repository/room_repository_impl.dart';
import 'package:get_it/get_it.dart';

class MainModule {
  static const baseUrl = "http://20.213.83.47:8080/";
  static const wsUrl = "ws://20.213.83.47:8080/";

  // static const baseUrl = "http://192.168.23.112:8080/";
  // static const wsUrl = "ws://192.168.23.112:8080/";

  static Future<void> init() async {
    GetIt.I.registerLazySingleton<Dio>(
      () => Dio().initClient(baseUrl),
    );

    GetIt.I.registerLazySingleton<RoomRepository>(() {
      return RoomRepositoryImpl(client: GetIt.I.get());
    });
    GetIt.I.registerLazySingleton<CreateRoomRepository>(() {
      return CreateRoomRepositoryImpl(client: GetIt.I.get());
    });
  }
}
