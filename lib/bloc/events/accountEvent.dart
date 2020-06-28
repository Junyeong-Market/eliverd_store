import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class NewAccountRequested extends AccountEvent {}

class AccountValidated extends AccountEvent {
  final Map<String, dynamic> jsonifiedUser;

  const AccountValidated(this.jsonifiedUser);

  @override
  List<Object> get props => [jsonifiedUser];

  @override
  String toString() {
    return 'AccountValidated{ jsonifiedUser: $jsonifiedUser }';
  }
}

class AccountCreated extends AccountEvent {
  final Map<String, dynamic> jsonifiedUser;

  const AccountCreated(this.jsonifiedUser);

  @override
  List<Object> get props => [jsonifiedUser];

  @override
  String toString() {
    return 'AccountCreated{ jsonifiedUser: $jsonifiedUser }';
  }
}
