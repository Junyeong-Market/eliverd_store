import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

class SearchUser extends SearchUserEvent {
  final String keyword;

  const SearchUser(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class SelectUser extends SearchUserEvent {
  final List<User> users;

  const SelectUser(this.users);

  @override
  List<Object> get props => [users];
}