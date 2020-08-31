import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:Eliverd/models/models.dart';

abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object> get props => [];
}

class StockNotFetchedState extends StockState {}

class StockFetchSuccessState extends StockState {
  final Store store;
  final List<Stock> stocks;
  final bool isAllFetched;

  const StockFetchSuccessState({@required this.store, @required this.stocks, this.isAllFetched});

  StockFetchSuccessState copyWith({Store store, List<Stock> stocks, bool isAllFetched}) {
    return StockFetchSuccessState(
      store: store,
      stocks: stocks,
      isAllFetched: isAllFetched,
    );
  }

  @override
  List<Object> get props => [store, stocks, isAllFetched];

  @override
  String toString() {
    return 'StockFetchSuccessState{ store: $store, stocks: $stocks, isAllFetched: $isAllFetched }';
  }
}

class StockFetchErrorState extends StockState {}
