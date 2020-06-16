import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/store.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

class StockLoaded extends StockEvent {}

class StockAdded extends StockEvent {
  final Stock stock;

  const StockAdded(this.stock);

  @override
  List<Object> get props => [stock];

  @override
  String toString() {
    return 'StockAdded{ stock: $stock }';
  }
}

class StockUpdated extends StockEvent {
  final Stock stock;

  const StockUpdated(this.stock);

  @override
  List<Object> get props => [stock];

  @override
  String toString() {
    return 'StockUpdated{ stock: $stock }';
  }
}

class StockDeleted extends StockEvent {
  final Stock stock;

  const StockDeleted(this.stock);

  @override
  List<Object> get props => [stock];

  @override
  String toString() {
    return 'StockDeleted{ stock: $stock }';
  }
}