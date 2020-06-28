import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class ValidateAuthentication extends AuthenticationEvent {
  final String token;

  const ValidateAuthentication(this.token);

  @override
  List<Object> get props => [token];

  @override
  String toString() {
    return 'ValidateAuthentication{ token: $token }';
  }
}

class SignInAuthentication extends AuthenticationEvent {
  final String userId;
  final String password;

  const SignInAuthentication(this.userId, this.password);

  @override
  List<Object> get props => [userId, password];

  @override
  String toString() {
    return 'SignInAuthentication{ userId: $userId, password: $password }';
  }
}

class SignOutAuthentication extends AuthenticationEvent {
  final String token;

  const SignOutAuthentication(this.token);

  @override
  List<Object> get props => [token];

  @override
  String toString() {
    return 'SignOutAuthentication{ token: $token }';
  }
}
