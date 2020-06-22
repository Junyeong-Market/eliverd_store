import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:Eliverd/models/models.dart';

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
      throw Exception('Error occurred while creating session');
    }

    final session = json.decode(res.body)['session'];

    return session;
  }

  Future<Map<String, dynamic>> validateSession(int session) async {
    final url = '$baseUrl/account/session';
    final res = await this.httpClient.get(url,
        headers: {
          'Authorization': session.toString(),
        }
    );

    if (res.statusCode != 200) {
      throw Exception('Error occurred while validating session');
    }

    final userInfo = json.decode(res.body);

    return userInfo;
  }

  Future<void> deleteSession(int session) async {
    final url = '$baseUrl/account/session';
    final res = await this.httpClient.delete(url,
      headers: {
        'Authorization': session.toString(),
      }
    );

    if (res.statusCode != 204) {
      throw Exception('Error occurred while deleting session');
    }
  }

  Future<Map<String, dynamic>> validateUser(Map<String, dynamic> jsonifiedUser) async {
    final url = '$baseUrl/account/user/validate';
    final res = await this.httpClient.post(
      url,
      body: jsonifiedUser,
      encoding: Encoding.getByName('application/json; charset=\'utf-8\''),
    );

    if (res.statusCode != 201) {
      throw Exception('Error occurred while validating user');
    }

    final data = json.decode(res.body);

    return data;
  }

  Future<List<User>> searchUser(String keyword) async {
    final url = '$baseUrl/account/user/search/$keyword?is_seller=true';
    final res = await this.httpClient.post(url);

    if (res.statusCode != 201) {
      throw Exception('Error occurred while searching user');
    }

    final data = json.decode(res.body)['results'] as List;

    return data.map((rawUser) {
      return User(
        userId: rawUser['user_id'],
        nickname: rawUser['nickname'],
        realname: rawUser['realname'],
        isSeller: rawUser['is_seller'],
      );
    }).toList();
  }
}
