import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class StockEvent extends Equatable {
  final Store currentStore;

  const StockEvent(this.currentStore);

  @override
  List<Object> get props => [currentStore];
}

class StockLoaded extends StockEvent {
  StockLoaded(Store currentStore) : super(currentStore);
}

class StockAdded extends StockEvent {
  final Stock stock;

  StockAdded(currentStore, this.stock) : super(currentStore);

  @override
  List<Object> get props => [stock, currentStore];

  @override
  String toString() {
    return 'StockAdded{ stock: $stock }';
  }
}

class StockUpdated extends StockEvent {
  final Stock stock;

  StockUpdated(currentStore, this.stock) : super(currentStore);

  @override
  List<Object> get props => [stock, currentStore];

  @override
  String toString() {
    return 'StockUpdated{ stock: $stock }';
  }
}

class StockDeleted extends StockEvent {
  final Stock stock;

  StockDeleted(currentStore, this.stock) : super(currentStore);

  @override
  List<Object> get props => [stock, currentStore];

  @override
  String toString() {
    return 'StockDeleted{ stock: $stock }';
  }
}
