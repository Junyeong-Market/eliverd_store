import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final int manufacturerId;
  final String ian;

  Product({this.id, this.name, this.manufacturerId, this.ian });

  @override
  List<Object> get props => [ id, name, manufacturerId, ian ];

  @override
  String toString() {
    return 'Product { id: $id, name: $name, manufacturer: $manufacturerId, ian: $ian}';
  }

  Product copyWith({ int id, String name, int manufacturerId, String ian }) {
    return Product(
      id: id,
      name: name,
      manufacturerId: manufacturerId,
      ian: ian,
    );
  }

  static Product fromJson(dynamic json) {
    return Product(
      id: json['id'],
      name: json['name'],
      manufacturerId: json['manufacturer'],
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
