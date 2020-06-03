import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String _id;
  final String _name;
  final String _manufacturer;
  final String _ian;

  Product(this._id, this._name, this._manufacturer, this._ian);

  @override
  List<Object> get props => [ _id, _name, _manufacturer, _ian ];

  @override
  String toString() {
    return 'Product { id: $_id, name: $_name, manufacturer: $_manufacturer, ian: $_ian}';
  }

  Product copyWith({ String id, String name, String manufacturer, String ian }) {
    return Product(id, name, manufacturer, ian);
  }
}

class Manufacturer extends Equatable {
  String _id;
  String _name;

  @override
  List<Object> get props => [_id, _name];

  @override
  String toString() {
    return 'Manufacturer { id: $_id, name: $_name }';
  }
  
  Manufacturer copyWith({ String id, String name }) {
    return Manufacturer(id, name);
  }
}
