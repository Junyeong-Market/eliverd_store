import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountEvent {}

class NewAccountRequested extends AccountEvent {}

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

class AccountError extends AccountEvent {}