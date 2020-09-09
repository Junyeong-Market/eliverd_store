import 'package:rxdart/rxdart.dart';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:Eliverd/bloc/events/stockEvent.dart';
import 'package:Eliverd/bloc/states/stockState.dart';

import 'package:Eliverd/resources/repositories/repositories.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StoreRepository storeRepository;

  StockBloc({@required this.storeRepository})
      : assert(storeRepository != null),
        super(StockNotFetchedState());

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
    if (event is LoadStock) {
      yield* _mapStockLoadedToState(event);
    } else if (event is AddStock) {
      yield* _mapStockAddedToState(event);
    } else if (event is UpdateStock) {
      yield* _mapStockUpdatedToState(event);
    } else if (event is DeleteStock) {
      yield* _mapStockDeletedToState(event);
    }
  }

  Stream<StockState> _mapStockLoadedToState(LoadStock event) async* {
    var currentState = state;

    if (currentState is StockFetchSuccessState &&
        currentState.store != event.store) {
      currentState = StockNotFetchedState();

      yield StockNotFetchedState();
    }

    if (!_isStockAllFetched(currentState)) {
      try {
        if (currentState is! StockFetchSuccessState) {
          final stocks = await storeRepository.fetchStock(
              event.store, event.name, event.category, event.orderBy);

          yield StockFetchSuccessState(
            store: event.store,
            stocks: stocks,
            isAllFetched: false,
          );
        } else {
          final stocks = await storeRepository.fetchStock(
              event.store, event.name, event.category, event.orderBy);
          yield stocks.isEmpty
              ? (currentState as StockFetchSuccessState)
                  .copyWith(isAllFetched: true)
              : StockFetchSuccessState(
                  store: event.store,
                  stocks: stocks,
                  isAllFetched: false,
                );
        }
      } catch (_) {
        yield StockFetchErrorState();
      }
    }
  }

  Stream<StockState> _mapStockAddedToState(AddStock event) async* {
    if (state is StockFetchSuccessState) {
      await storeRepository.addStock(
          event.stock.store.id, event.stock.toMutateRequestJson());

      final stocks = await storeRepository.fetchStock(event.stock.store);

      yield StockFetchSuccessState(
        store: event.stock.store,
        stocks: stocks,
        isAllFetched: false,
      );
    }
  }

  Stream<StockState> _mapStockUpdatedToState(UpdateStock event) async* {
    if (state is StockFetchSuccessState) {
      await storeRepository.updateStock(event.stock);

      final stocks = await storeRepository.fetchStock(event.stock.store);

      yield StockFetchSuccessState(
        store: event.stock.store,
        stocks: stocks,
        isAllFetched: false,
      );
    }
  }

  Stream<StockState> _mapStockDeletedToState(DeleteStock event) async* {
    if (state is StockFetchSuccessState) {
      await storeRepository.removeStock(event.stock);

      final stocks = await storeRepository.fetchStock(event.stock.store);

      yield StockFetchSuccessState(
        store: event.stock.store,
        stocks: stocks,
        isAllFetched: false,
      );
    }
  }

  bool _isStockAllFetched(StockState state) =>
      state is StockFetchSuccessState && state.isAllFetched;
}
