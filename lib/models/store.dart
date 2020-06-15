import 'package:equatable/equatable.dart';

class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);
}

class Store extends Equatable {
  final int id;
  final String name;
  final String description;
  final int registerer;
  final String registeredNumber;
  final Point location;

  const Store({this.id, this.name, this.description, this.registerer, this.registeredNumber, this.location});

  @override
  List<Object> get props => [ id, name, description, registerer, registeredNumber, location ];

  @override
  String toString() {
    return 'Store { id: $id, name: $name, description: $description, registerer: $registerer, registeredNumber: $registeredNumber, location: $location}';
  }

  Store copyWith({int id, String name, String description, int registerer, String registeredNumber, Point location}) {
    return Store(
      id: id,
      name: name,
      description: description,
      registerer: registerer,
      registeredNumber: registeredNumber,
      location: location
    );
  }

  static Store fromJson(dynamic json) {
    return Store(
      id: json['number'],
      name: json['name'],
      description: json['description'],
      registerer: json['registerer'],
      registeredNumber: json['registerer_number'],
      location: json['point']
    );
  }
}

class Stock extends Equatable {
  final int storeId;
  final int productId;
  final int price;
  final int amount;

  const Stock({this.storeId, this.productId, this.price, this.amount});

  @override
  List<Object> get props => [storeId, productId, price, amount ];

  @override
  String toString() {
    return 'Stock{store: $storeId, product: $productId, price: $price, amount: $amount}';
  }

  Stock copyWith({ int storeId, int product, int price, int amount }) {
    return Stock(
      storeId: storeId,
      productId: product,
      price: price,
      amount: amount,
    );
  }
}