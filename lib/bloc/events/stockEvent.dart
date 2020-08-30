import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:Eliverd/models/models.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

class LoadStock extends StockEvent {
  final Store store;
  final String category;
  final String name;
  final String orderBy;

  const LoadStock({@required this.store, this.category, this.name, this.orderBy});

  @override
  List<Object> get props => [store, category, name, orderBy];

  @override
  String toString() {
    return 'LoadStock{ store: $store, category: $category, name: $name, orderBy: $orderBy }';
  }
}

class AddStock extends StockEvent {
  final Stock stock;

  const AddStock(this.stock);

  @override
  List<Object> get props => [stock];

  @override
  String toString() {
    return 'AddStock{ stock: $stock }';
  }
}

class UpdateStock extends StockEvent {
  final Stock stock;

  const UpdateStock(this.stock);

  @override
  List<Object> get props => [stock];

  @override
  String toString() {
    return 'UpdateStock{ stock: $stock }';
  }
}

class DeleteStock extends StockEvent {
  final Stock stock;

  const DeleteStock(this.stock);

  @override
  List<Object> get props => [stock];

  @override
  String toString() {
    return 'DeleteStock{ stock: $stock }';
  }
}