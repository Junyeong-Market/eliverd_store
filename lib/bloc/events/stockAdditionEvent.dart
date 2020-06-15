import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class StockAdditionEvent extends Equatable {
  const StockAdditionEvent();
}

class AddStock extends StockAdditionEvent {
  final String storeId;
  final Map<String, dynamic> jsonifiedProduct;

  const AddStock({@required this.storeId, @required this.jsonifiedProduct}) : assert(storeId != null && jsonifiedProduct != null);

  @override
  List<Object> get props => [storeId, jsonifiedProduct];
}