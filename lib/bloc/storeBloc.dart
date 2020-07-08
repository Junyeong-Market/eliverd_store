import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/resources/repositories/repositories.dart';

import 'package:Eliverd/bloc/events/storeEvent.dart';
import 'package:Eliverd/bloc/states/storeState.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository storeRepository;

  StoreBloc({@required this.storeRepository})
      : assert(storeRepository != null);

  @override
  StoreState get initialState => StoreNotCreated();

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is CreateStore) {
      yield* _mapCreateStoreToState(event);
    } else if (event is RegisterStoreRegisterers) {
      yield* _mapRegisterStoreRegisterersToState(event);
    } else if (event is RegisterStoreLocation) {
      yield* _mapRegisterStoreLocationToState(event);
    }
  }

  Stream<StoreState> _mapCreateStoreToState(CreateStore event) async* {
    try {
      await storeRepository.createStore(event.store.toJson());

      yield StoreCreated();
    } catch (_) {
      yield StoreError();
    }
  }

  Stream<StoreState> _mapRegisterStoreRegisterersToState(RegisterStoreRegisterers event) async* {
    yield StoreRegisterersRegistered(event.registerers);
  }

  Stream<StoreState> _mapRegisterStoreLocationToState(RegisterStoreLocation event) async* {
    yield StoreLocationRegistered(event.location);
  }
}
