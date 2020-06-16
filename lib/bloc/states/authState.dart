import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class NotAuthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {}
