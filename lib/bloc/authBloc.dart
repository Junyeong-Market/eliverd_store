import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:Eliverd/bloc/events/authEvent.dart';
import 'package:Eliverd/bloc/states/authState.dart';

import 'package:Eliverd/resources/repositories/repositories.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AccountRepository accountRepository;

  AuthenticationBloc({ @required this.accountRepository }) : assert(accountRepository != null);

  @override
  AuthenticationState get initialState => NotAuthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is ValidateAuthentication) {
      yield* _mapValidateAuthenticationToState(event);
    } else if (event is SignInAuthentication) {
      yield* _mapSignInAuthenticationToState(event);
    } else if (event is SignOutAuthentication) {
      yield* _mapSignOutAuthenticationToState(event);
    }
  }

  Stream<AuthenticationState> _mapValidateAuthenticationToState(ValidateAuthentication event) async* {
    // TO-DO: 현재 세션 토큰 불러오기
    final currentToken = 1;

    if (currentToken.isNaN) {
      yield NotAuthenticated();
    } else {
      yield Authenticated();
    }
  }

  Stream<AuthenticationState> _mapSignInAuthenticationToState(SignInAuthentication event) async* {
    final session = await accountRepository.createSession(event.userId, event.password);

    if (session != null) {
      yield Authenticated();
    } else {
      yield NotAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapSignOutAuthenticationToState(SignOutAuthentication event) async* {
    await accountRepository.deleteSession(event.token);

    yield NotAuthenticated();
  }

}