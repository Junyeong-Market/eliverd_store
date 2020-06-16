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
  final List<Stock> stocks;
  final bool isAllFetched;

  const StockFetchSuccessState({@required this.stocks, this.isAllFetched})
      : assert(stocks != null);

  StockFetchSuccessState copyWith({List<Stock> stocks, bool isAllFetched}) {
    return StockFetchSuccessState(
      stocks: stocks,
      isAllFetched: isAllFetched,
    );
  }

  @override
  List<Object> get props => [stocks, isAllFetched];

  @override
  String toString() {
    return 'StockFetchSuccessState{ stocks: $stocks, isAllFetched: $isAllFetched }';
  }
}

class StockFetchErrorState extends StockState {}
