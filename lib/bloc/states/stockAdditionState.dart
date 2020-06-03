import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:Eliverd/models/product.dart';

abstract class StockAdditionState extends Equatable {
  const StockAdditionState();

  @override
  List<Object> get props => [];
}

class StockNotAddedState extends StockAdditionState {}

class StockAddedState extends StockAdditionState {
  final Product product;

  const StockAddedState({@required this.product}) : assert(product != null);

  @override
  List<Object> get props => [product];
}

class StockAdditionErrorState extends StockAdditionState {}