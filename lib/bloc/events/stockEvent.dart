import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

class LoadStock extends StockEvent {
  final Store store;

  const LoadStock(this.store);

  @override
  List<Object> get props => [store];
}

class AddStock extends StockEvent {
  final Stock stock;

  const AddStock(this.stock);

  @override
  List<Object> get props => [stock];
}

class UpdateStock extends StockEvent {
  final Stock stock;

  const UpdateStock(this.stock);

  @override
  List<Object> get props => [stock];
}

class DeleteStock extends StockEvent {
  final Stock stock;

  const DeleteStock(this.stock);

  @override
  List<Object> get props => [stock];
}