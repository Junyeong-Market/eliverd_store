import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountNotExist extends AccountState {}

class AccountExist extends AccountState {}