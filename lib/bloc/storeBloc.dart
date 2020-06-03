import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:Eliverd/models/product.dart';

import 'package:Eliverd/resources/repository.dart';

import 'package:Eliverd/bloc/states/stockAdditionState.dart';
import 'package:Eliverd/bloc/events/stockAdditionEvent.dart';

class StockAdditionBloc extends Bloc<StockAdditionEvent, StockAdditionState> {
  final StoreRepository storeRepository;

  StockAdditionBloc({@required this.storeRepository})
    : assert(storeRepository != null);

  @override
  StockAdditionState get initialState => StockNotAddedState();

  @override
  Stream<StockAdditionState> mapEventToState(StockAdditionEvent event) async* {
    if (event is AddStock) {
      yield StockNotAddedState();
      try {
        final Product product = await storeRepository.addStock(event.storeId, event.product);
        yield StockAddedState(product: product);
      } catch (_) {
        yield StockAdditionErrorState();
      }
    }
  }
}