import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:Eliverd/bloc/events/authEvent.dart';
import 'package:Eliverd/bloc/states/authState.dart';

import 'package:Eliverd/models/models.dart';
import 'package:Eliverd/resources/repositories/repositories.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AccountRepository accountRepository;
  final StoreRepository storeRepository;

  AuthenticationBloc(
      {@required this.accountRepository, @required this.storeRepository})
      : assert(accountRepository != null),
        assert(storeRepository != null);

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
    try {
      final session = int.parse(event.token);
      final data = await accountRepository.validateSession(session);

      if (data.isEmpty) {
        yield NotAuthenticated();
      }

      final authenticatedUser = User(
        userId: data['user_id'],
        nickname: data['nickname'],
        realname: data['realname'],
        isSeller: data['is_seller'],
      );

      final stores = await Future.wait((data['stores'] as List)
          .map((storeId) async => await storeRepository.getStore(storeId))
          .toList());

      yield Authenticated(authenticatedUser, stores);
    } catch (_) {
      yield AuthenticationError();
    }
  }

  Stream<AuthenticationState> _mapSignInAuthenticationToState(
      SignInAuthentication event) async* {
    try {
      final session =
          await accountRepository.createSession(event.userId, event.password);

      if (session == null) {
        yield NotAuthenticated();
      }

      final data = await accountRepository.validateSession(session.id);

      final authenticatedUser = User(
        userId: data['user_id'],
        nickname: data['nickname'],
        realname: data['realname'],
        isSeller: data['is_seller'],
      );

      final stores = await Future.wait((data['stores'] as List)
          .map((storeId) async => await storeRepository.getStore(storeId))
          .toList());

      yield Authenticated(authenticatedUser, stores);
    } catch (_) {
      yield AuthenticationError();
    }
  }

  Stream<AuthenticationState> _mapSignOutAuthenticationToState(
      SignOutAuthentication event) async* {
    try {
      final session = int.parse(event.token);
      await accountRepository.deleteSession(session);

      yield NotAuthenticated();
    } catch (_) {
      yield AuthenticationError();
    }
  }
}
