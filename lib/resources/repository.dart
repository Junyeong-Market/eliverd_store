import 'dart:async';

import 'package:meta/meta.dart';

import 'package:Eliverd/resources/storeProvider.dart';
import 'package:Eliverd/models/product.dart';
import 'package:Eliverd/models/store.dart';

class StoreRepository {
  final StoreAPIClient storeAPIClient;

  StoreRepository({@required this.storeAPIClient})
    : assert(storeAPIClient != null);

  Future<Store> createStore(Map<String, dynamic> jsonifiedStore) async {
    final store = await storeAPIClient.createStore(jsonifiedStore);

    return store;
  }

  Future<List<Stock>> fetchStock(int storeId) async {
    final stocks = await storeAPIClient.fetchStock(storeId);

    return stocks;
  }

  Future<Product> addStock(String storeId, Map<String, dynamic> jsonifiedProduct) async {
    final product = await storeAPIClient.addStock(storeId, jsonifiedProduct);

    return product;
  }

  Future<void> removeStock(String storeId, String productId) async {
    // TO-DO: 구현 이후 수정
    await storeAPIClient.removeStock(storeId, productId);
  }
}