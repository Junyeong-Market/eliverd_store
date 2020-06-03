import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/user.dart';
import 'package:Eliverd/models/product.dart';

class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);
}

class Store extends Equatable {
  final String id;
  final String name;
  final String description;
  final User registerer;
  final String registeredNumber;
  final Point location;

  const Store({this.id, this.name, this.description, this.registerer, this.registeredNumber, this.location});

  @override
  List<Object> get props => [ id, name, description, registerer, registeredNumber, location ];


  @override
  String toString() {
    return 'Store { id: $id, name: $name, description: $description, registerer: $registerer, registeredNumber: $registeredNumber, location: $location}';
  }

  Store copyWith({String id, String name, String description, User registerer, String registeredNumber, Point location}) {
    return Store(
      id: id,
      name: name,
      description: description,
      registerer: registerer,
      registeredNumber: registeredNumber,
      location: location
    );
  }
}

class Stock extends Equatable {
  final Store store;
  final Product product;
  final int price;
  final int amount;

  Stock({this.store, this.product, this.price, this.amount});

  @override
  List<Object> get props => [store, product, price, amount ];

  @override
  String toString() {
    return 'Stock{store: $store, product: $product, price: $price, amount: $amount}';
  }

  Stock copyWith({ Store store, Product product, int price, int amount }) {
    return Stock(
      store: store,
      product: product,
      price: price,
      amount: amount,
    );
  }
}