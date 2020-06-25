import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/resources/repositories/repositories.dart';

import 'package:Eliverd/bloc/events/storeEvent.dart';
import 'package:Eliverd/bloc/states/storeState.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository storeRepository;

  StoreBloc({@required this.storeRepository}) : assert(storeRepository != null);

  @override
  StoreState get initialState => StoreNotCreated();

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    try {
      if (event is CreateStore) {
        await storeRepository.createStore(event.store.toJson());

        yield StoreCreated();
      } else if (event is SearchRegisterers) {
        yield RegisterersSearching();
      } else if (event is SelectRegisterers) {
        yield RegisterersSelected(event.registerers);
      }
    } catch (_) {
      yield StoreError();
    }
  }
}
