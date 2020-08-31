import 'dart:async';

import 'package:meta/meta.dart';

import 'package:Eliverd/resources/providers/providers.dart';
import 'package:Eliverd/models/models.dart';

class AccountRepository {
  final AccountAPIClient accountAPIClient;

  AccountRepository({@required this.accountAPIClient})
      : assert(accountAPIClient != null);

  Future<void> signUpUser(Map<String, dynamic> user) async {
    await accountAPIClient.signUpUser(user);
  }

  Future<Map<String, dynamic>> validateUser(Map<String, dynamic> user) async {
    final validation = await accountAPIClient.validateUser(user);

    return validation;
  }

  Future<List<User>> searchUser(String keyword) async {
    final users = await accountAPIClient.searchUser(keyword);

    return users;
  }

  Future<String> createSession([String userId, String password]) async {
    final session = await accountAPIClient.createSession(userId, password);

    return session;
  }

  Future<User> validateSession() async {
    final user = await accountAPIClient.validateSession();

    return user;
  }

  Future<void> deleteSession() async {
    await accountAPIClient.deleteSession();
  }
}