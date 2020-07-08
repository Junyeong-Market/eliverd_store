import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/resources/repositories/repositories.dart';

import 'package:Eliverd/bloc/events/searchManufacturerEvent.dart';
import 'package:Eliverd/bloc/states/searchManufacturerState.dart';

class SearchManufacturerBloc extends Bloc<SearchManufacturerEvent, SearchManufacturerState> {
  final StoreRepository storeRepository;

  SearchManufacturerBloc({@required this.storeRepository})
      : assert(storeRepository != null);

  @override
  SearchManufacturerState get initialState => ManufacturerNotFound();

  @override
  Stream<SearchManufacturerState> mapEventToState(SearchManufacturerEvent event) async* {
    if (event is SearchManufacturer) {
      try {
        final manufacturers = await storeRepository.searchManufacturer(event.keyword);

        yield ManufacturerFound(manufacturers);
      } catch (_) {
        yield ManufacturerFound([]);
      }
    }
  }

}