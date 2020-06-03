import 'dart:async';

import 'package:meta/meta.dart';

import 'package:Eliverd/resources/storeProvider.dart';
import 'package:Eliverd/models/product.dart';
import 'package:Eliverd/models/store.dart';

class StoreRepository {
  final StoreAPIClient storeAPIClient;

  StoreRepository({@required this.storeAPIClient})
    : assert(storeAPIClient != null);

  Future<List<Stock>> fetchStock(String storeId) {
    return storeAPIClient.fetchStock(storeId);
  }

  Future<Product> addStock(String storeId, Product product) {
    return storeAPIClient.addStock(storeId, product);
  }

  Future<Product> removeStock(String storeId, String productId) {
    return storeAPIClient.removeStock(storeId, productId);
  }
}