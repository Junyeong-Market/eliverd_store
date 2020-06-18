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
  AccountState get initialState => AccountInitial();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is AccountCreated) {
      yield* _mapAccountCreatedToState(event);
    } else if (event is NewAccountRequested) {
      yield* _mapNewAccountRequestedToState(event);
    } else if (event is AccountValidated) {
      yield* _mapAccountValidatedToState(event);
    }
  }

  Stream<AccountState> _mapAccountCreatedToState(AccountCreated event) async* {
    try {
      if (state is! AccountValidateFailed) {
        await accountRepository.signUpUser(event.jsonifiedUser);

        yield AccountDoneCreate();
      }
    } catch (_) {
      yield AccountError();
    }
  }

  Stream<AccountState> _mapNewAccountRequestedToState(
      NewAccountRequested event) async* {
    yield AccountOnCreate();
  }

  Stream<AccountState> _mapAccountValidatedToState(AccountValidated event) async* {
    try {
      final validation = await accountRepository.validateUser(event.jsonifiedUser);

      if (!validation.values.every((element) => element == 0)) {
        yield AccountValidateFailed(validation);
      }
    } catch (_) {
      yield AccountError();
    }
  }
}
