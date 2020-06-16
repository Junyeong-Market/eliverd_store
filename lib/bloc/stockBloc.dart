import 'package:rxdart/rxdart.dart';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:Eliverd/bloc/events/stockEvent.dart';
import 'package:Eliverd/bloc/states/stockState.dart';

import 'package:Eliverd/resources/repository.dart';

import 'package:Eliverd/models/store.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StoreRepository storeRepository;
  final Store currentStore;

  StockBloc({@required this.storeRepository, @required this.currentStore})
      : assert(storeRepository != null && currentStore != null);

  @override
  StockState get initialState => StockNotFetchedState();

  @override
  Stream<Transition<StockEvent, StockState>> transformEvents(
      Stream<StockEvent> events,
      TransitionFunction<StockEvent, StockState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<StockState> mapEventToState(StockEvent event) async* {
    if (event is StockLoaded) {
      yield* _mapStockLoadedToState(event);
    } else if (event is StockAdded) {
      yield* _mapStockAddedToState(event);
    } else if (event is StockUpdated) {
      yield* _mapStockUpdatedToState(event);
    } else if (event is StockDeleted) {
      yield* _mapStockDeletedToState(event);
    }
  }
  
  Stream<StockState> _mapStockLoadedToState(StockEvent event) async* {
    final currentState = state;
    if (!_isStockAllFetched(currentState)) {
      try {
        if (currentState is StockNotFetchedState) {
          final stocks = await storeRepository.fetchStock(currentStore);
          yield StockFetchSuccessState(stocks: stocks, isAllFetched: false);
          return;
        }
        if (currentState is StockFetchSuccessState) {
          final stocks = await storeRepository.fetchStock(currentStore);
          yield stocks.isEmpty
              ? currentState.copyWith(isAllFetched: true)
              : StockFetchSuccessState(
            stocks: currentState.stocks + stocks,
            isAllFetched: false,
          );
        }
      } catch (_) {
        yield StockFetchErrorState();
      }
    }
  }

  Stream<StockState> _mapStockAddedToState(StockAdded event) async* {
    if (state is StockFetchSuccessState) {
      final List<Stock> updatedStocks = (state as StockFetchSuccessState).stocks.toList()..add(event.stock);
      yield StockFetchSuccessState(stocks: updatedStocks, isAllFetched: true);
    }
  }

  Stream<StockState> _mapStockUpdatedToState(StockUpdated event) async* {
    if (state is StockFetchSuccessState) {
      final List<Stock> updatedStocks = (state as StockFetchSuccessState)
          .stocks
          .toList()
          ..map((stock) => stock.product.id == event.stock.product.id ? event.stock : stock);
      yield StockFetchSuccessState(stocks: updatedStocks, isAllFetched: true);
    }
  }

  Stream<StockState> _mapStockDeletedToState(StockDeleted event) async* {
    if (state is StockFetchSuccessState) {
      final List<Stock> updatedStocks = (state as StockFetchSuccessState).stocks.toList()..remove(event.stock);
      yield StockFetchSuccessState(stocks: updatedStocks, isAllFetched: true);
    }
  }

  bool _isStockAllFetched(StockState state) => state is StockFetchSuccessState && state.isAllFetched;
}