import 'dart:async';

import 'package:meta/meta.dart';

import 'package:Eliverd/resources/providers/providers.dart';
import 'package:Eliverd/models/models.dart';

class AccountRepository {
  final AccountAPIClient accountAPIClient;

  AccountRepository({@required this.accountAPIClient})
      : assert(accountAPIClient != null);

  Future<User> signUpUser(Map<String, dynamic> jsonifiedUser) async {
    final user = await accountAPIClient.signUpUser(jsonifiedUser);

    return user;
  }

  Future<Map<String, dynamic>> validateUser(Map<String, dynamic> jsonifiedUser) async {
    final validation = await accountAPIClient.validateUser(jsonifiedUser);

    return validation;
  }

  Future<Session> createSession(String userId, String password) async {
    final session = await accountAPIClient.createSession(userId, password);

    return session;
  }

  Future<Map<String, dynamic>> validateSession(int session) async {
    final userInfo = await accountAPIClient.validateSession(session);

    return userInfo;
  }

  Future<void> deleteSession(int session) async {
    await accountAPIClient.deleteSession(session);
  }
}