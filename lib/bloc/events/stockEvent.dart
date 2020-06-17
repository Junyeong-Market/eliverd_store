import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

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
}

class StockUpdated extends StockEvent {
  final Stock stock;

  const StockUpdated(this.stock);

  @override
  List<Object> get props => [stock];
}

class StockDeleted extends StockEvent {
  final Stock stock;

  const StockDeleted(this.stock);

  @override
  List<Object> get props => [stock];
}