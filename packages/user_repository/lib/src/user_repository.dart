import 'dart:convert';
import 'dart:typed_data';

import 'package:local_data/local_data.dart';

import 'models/user_model.dart';
import 'package:http/http.dart' as http;

class RequestFailure implements Exception {}

class ResponseFailure implements Exception {}

class UserRepository {
  User? _user;

  final LocalData _localData;

  late final http.Client _httpClient;

  static const _baseUrl = '20.213.83.47:8080';

  UserRepository(LocalData localData, {http.Client? httpClient})
      : _localData = localData,
        _httpClient = httpClient ?? http.Client();

  Map<String, String>? getAuthorization() {
    if (_localData.token.getToken().isEmpty) return null;

    return {
      'x-access-token': _localData.token.getToken(),
    };
  }

  Future<User?> getUser({bool force = false}) async {
    if (_user != null && !force) return _user;

    final uri = Uri.http(
      _baseUrl,
      '/api/profile',
    );

    var headers = getAuthorization();

    if (headers == null) throw RequestFailure();

    final response = await _httpClient.get(uri, headers: headers);

    if (response.statusCode != 200) throw RequestFailure();

    if (response.body.isEmpty) throw ResponseFailure();

    final resultJson = jsonDecode(response.body) as Map;

    if (resultJson.containsKey('status')) {
      if (resultJson['status'] != 'success') throw RequestFailure();
    }

    if (resultJson.isEmpty) throw ResponseFailure();

    _user = User.fromMap(resultJson as Map<String, dynamic>);

    return _user;
  }

  Future<void> updateUser(
      {String? username, Uint8List? imageBytes, String? fileName}) async {
    if (username == null && imageBytes == null) return;

    final uri = Uri.http(
      _baseUrl,
      '/api/user',
    );

    var headers = getAuthorization();

    if (headers == null) throw RequestFailure();

    headers.addEntries([
      const MapEntry('Content-Type', 'multipart/form-data'),
    ]);

    var request = http.MultipartRequest('PUT', uri);

    request.headers.addAll(headers);

    if (username != null) {
      request.fields.addAll({
        'username': username,
      });
    }

    if (imageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('profilePic', imageBytes,
          filename: fileName));
    }

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode != 200) throw RequestFailure();
  }
}
