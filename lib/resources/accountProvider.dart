import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:Eliverd/models/user.dart';

class AccountAPIClient {
  // TO-DO: 백엔드 API 공식 배포 후 수정
  static const baseUrl = 'http://localhost:8000';
  final http.Client httpClient;

  AccountAPIClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<User> signUpUser(Map<String, dynamic> jsonifiedUser) async {
    final url = '$baseUrl/account/user';
    final res = await this.httpClient.post(
      url,
      body: jsonifiedUser,
      encoding: Encoding.getByName('application/json; charset=\'utf-8\''),
    );

    if (res.statusCode != 201) {
      throw Exception('Error occurred while registering user');
    }

    final data = json.decode(res.body) as User;

    return data;
  }

  Future<Session> createSession(String userId, String password) async {
    final Map<String, dynamic> user = {
      'user_id': userId,
      'password': password
    };

    final url = '$baseUrl/account/session';
    final res = await this.httpClient.post(
      url,
      body: user,
      encoding: Encoding.getByName('application/json; charset=\'utf-8\''),
    );

    if (res.statusCode != 201) {
      throw Exception('Error occurred while deleting session');
    }

    final session = json.decode(res.body)['session'];

    return session;
  }

  Future<void> deleteSession(String session) async {
    final url = '$baseUrl/account/session';
    final res = await this.httpClient.delete(url,
      headers: {
        'Authorization': session
      }
    );

    if (res.statusCode != 204) {
      throw Exception('Error occurred while deleting session');
    }
  }
}
