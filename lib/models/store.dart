import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);
}

class Store extends Equatable {
  final int id;
  final String name;
  final String description;
  final User registerer;
  final String registeredNumber;
  final Point location;

  const Store(
      {this.id,
      this.name,
      this.description,
      this.registerer,
      this.registeredNumber,
      this.location});

  @override
  List<Object> get props =>
      [id, name, description, registerer, registeredNumber, location];

  @override
  String toString() {
    return 'Store { id: $id, name: $name, description: $description, registerer: $registerer, registeredNumber: $registeredNumber, location: $location}';
  }

  Store copyWith(
          {int id,
          String name,
          String description,
          User registerer,
          String registeredNumber,
          Point location}) =>
      Store(
          id: id,
          name: name,
          description: description,
          registerer: registerer,
          registeredNumber: registeredNumber,
          location: location);

  static Store fromJson(dynamic json) => Store(
      id: json['number'],
      name: json['name'],
      description: json['description'],
      registerer: json['registerer'],
      registeredNumber: json['registerer_number'],
      location: json['point']);
}

class Stock extends Equatable {
  final Store store;
  final Product product;
  final int price;
  final int amount;

  const Stock({this.store, this.product, this.price, this.amount});

  @override
  List<Object> get props => [store, product, price, amount];

  @override
  String toString() =>
      'Stock{store: $store, product: $product, price: $price, amount: $amount}';

  Stock copyWith({Store store, Product product, int price, int amount}) =>
      Stock(
        store: store,
        product: product,
        price: price,
        amount: amount,
      );

  Map<String, dynamic> toJson() => {
        'ian': product.ian,
        'name': product.name,
        'manufacturer': product.manufacturer.name,
        'amount': amount,
      };
}
