import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class NotAuthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User user;
  final Store store;

  const Authenticated(this.user, this.store);

  @override
  List<Object> get props => [user, store];
}

class AuthenticationError extends AuthenticationState {}
