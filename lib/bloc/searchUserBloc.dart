import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/resources/repositories/repositories.dart';

import 'package:Eliverd/bloc/events/searchUserEvent.dart';
import 'package:Eliverd/bloc/states/searchUserState.dart';

import 'events/searchUserEvent.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final AccountRepository accountRepository;

  SearchUserBloc({@required this.accountRepository})
      : assert(accountRepository != null);

  @override
  SearchUserState get initialState => UserNotFound();

  @override
  Stream<SearchUserState> mapEventToState(SearchUserEvent event) async* {
    if (event is SearchUser) {
      try {
        final users = await accountRepository.searchUser(event.keyword);

        yield UserFound(users);
      } catch (_) {
        yield UserFound([]);
      }
    }
  }

}