import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object> get props => [];
}

class UserNotFound extends SearchUserState {}

class UserFound extends SearchUserState {
  final List<User> users;

  const UserFound(this.users);

  @override
  List<Object> get props => [users];
}