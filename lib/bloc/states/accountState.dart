import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountOnCreate extends AccountState {}

class AccountDoneCreate extends AccountState {}

class AccountError extends AccountState {}