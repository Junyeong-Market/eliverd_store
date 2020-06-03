import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final Manufacturer manufacturer;
  final String ian;

  Product({this.id, this.name, this.manufacturer, this.ian });

  @override
  List<Object> get props => [ id, name, manufacturer, ian ];

  @override
  String toString() {
    return 'Product { id: $id, name: $name, manufacturer: $manufacturer, ian: $ian}';
  }

  Product copyWith({ String id, String name, Manufacturer manufacturer, String ian }) {
    return Product(
      id: id,
      name: name,
      manufacturer: manufacturer,
      ian: ian,
    );
  }

  static Product fromJson(dynamic json) {
    return Product(
      id: json['id'],
      name: json['name'],
      manufacturer: json['manufacturer'],
      ian: json['ian'],
    );
  }
}

class Manufacturer extends Equatable {
  final String id;
  final String name;

  Manufacturer({this.id, this.name});

  @override
  List<Object> get props => [id, name];

  @override
  String toString() {
    return 'Manufacturer { id: $id, name: $name }';
  }

  Manufacturer copyWith({ String id, String name }) {
    return Manufacturer(
      id: id,
      name: name,
    );
  }
}
