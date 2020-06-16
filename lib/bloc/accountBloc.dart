import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/resources/repositories/repositories.dart';

import 'package:Eliverd/bloc/events/accountEvent.dart';
import 'package:Eliverd/bloc/states/accountState.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;

  AccountBloc({@required this.accountRepository})
      : assert(accountRepository != null);

  @override
  AccountState get initialState => AccountExist();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is AccountCreated) {
      yield* _mapAccountCreatedToState(event);
    } else if (event is NewAccountRequested) {
      yield* _mapNewAccountRequestedToState(event);
    } else if (event is AccountError) {
      yield* _mapAccountErrorToState(event);
    }
  }

  Stream<AccountState> _mapAccountCreatedToState(AccountCreated event) async* {
    await accountRepository.signUpUser(event.jsonifiedUser);

    yield AccountExist();
  }

  Stream<AccountState> _mapNewAccountRequestedToState(
      NewAccountRequested event) async* {
    yield AccountNotExist();
  }

  Stream<AccountState> _mapAccountErrorToState(AccountError event) async* {
    yield AccountNotExist();
  }
}
