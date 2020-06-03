import 'package:Eliverd/models/product.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class StockAdditionEvent extends Equatable {
  const StockAdditionEvent();
}

class AddStock extends StockAdditionEvent {
  final String storeId;
  final Product product;

  const AddStock({@required this.storeId, @required this.product}) : assert(storeId != null && product != null);

  @override
  List<Object> get props => [storeId, product];
}