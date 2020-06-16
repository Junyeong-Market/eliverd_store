import 'dart:async';

import 'package:meta/meta.dart';

import 'package:Eliverd/resources/providers/providers.dart';
import 'package:Eliverd/models/models.dart';

class AccountRepository {
  final AccountAPIClient accountAPIClient;

  AccountRepository({@required this.accountAPIClient})
      : assert(accountAPIClient != null);

  Future<User> signUpUser(Map<String, dynamic> jsonifiedUser) async {
    final user = accountAPIClient.signUpUser(jsonifiedUser);

    return user;
  }

  Future<Session> createSession(String userId, String password) async {
    final session = accountAPIClient.createSession(userId, password);

    return session;
  }

  Future<void> deleteSession(String session) async {
    await accountAPIClient.deleteSession(session);
  }
}