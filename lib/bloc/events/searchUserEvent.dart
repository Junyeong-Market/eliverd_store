import 'package:equatable/equatable.dart';

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