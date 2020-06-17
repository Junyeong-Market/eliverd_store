import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:Eliverd/bloc/events/authEvent.dart';
import 'package:Eliverd/bloc/states/authState.dart';

import 'package:Eliverd/models/models.dart';
import 'package:Eliverd/resources/repositories/repositories.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AccountRepository accountRepository;

  AuthenticationBloc({@required this.accountRepository})
      : assert(accountRepository != null);

  @override
  AuthenticationState get initialState => NotAuthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is ValidateAuthentication) {
      yield* _mapValidateAuthenticationToState(event);
    } else if (event is SignInAuthentication) {
      yield* _mapSignInAuthenticationToState(event);
    } else if (event is SignOutAuthentication) {
      yield* _mapSignOutAuthenticationToState(event);
    }
  }

  Stream<AuthenticationState> _mapValidateAuthenticationToState(
      ValidateAuthentication event) async* {
    final session = int.parse(event.token);
    final data = await accountRepository.validateSession(session);

    if (data.isEmpty) {
      yield NotAuthenticated();
    }

    // TO-DO: Authenticated state 재정의 후 수정
    final authenticatedUser =
        User(userId: data['user_id'], nickname: data['nickname']);

    final stores = Store();

    yield Authenticated(authenticatedUser, stores);
  }

  Stream<AuthenticationState> _mapSignInAuthenticationToState(
      SignInAuthentication event) async* {
    final session =
        await accountRepository.createSession(event.userId, event.password);

    if (session == null) {
      yield NotAuthenticated();
    }

    final data = await accountRepository.validateSession(session.id);

    // TO-DO: Authenticated state 재정의 후 수정
    final authenticatedUser =
        User(userId: data['user_id'], nickname: data['nickname']);

    final stores = Store();

    yield Authenticated(authenticatedUser, stores);
  }

  Stream<AuthenticationState> _mapSignOutAuthenticationToState(
      SignOutAuthentication event) async* {
    final session = int.parse(event.token);
    await accountRepository.deleteSession(session);

    yield NotAuthenticated();
  }
}
