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
  final List<Store> stores;

  const Authenticated(this.user, this.stores);

  @override
  List<Object> get props => [user, stores];
}

class AuthenticationError extends AuthenticationState {}
